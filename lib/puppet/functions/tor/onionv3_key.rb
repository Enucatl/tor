# Function that generates and stores a onionv3 key on the
# filesystem and returns the generated data
# If the key and data already exists, it will only read
# the data from disk.
#
# Result: { 'hs_ed25519_secret_key' => 'binary data',
#     'hs_ed25519_public_key' => 'binary_data',
#     'hostname' => 'ONIONV3_HOSTNAME.onion' }
require 'fileutils'
require 'ed25519'
require 'base32'
Puppet::Functions.create_function(:'tor::onionv3_key') do
  dispatch :get do
    param 'String', :base_dir
    param 'String', :name
  end

  def get(base_dir, name)
    path = File.join(base_dir,name)

    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end

    unless all_files_exist?(path)
      generate_data(path)
    end

    res = read_data(path)
    res['hs_ed25519_secret_key'] = Puppet::Pops::Types::PSensitiveType::Sensitive.new(res['hs_ed25519_secret_key'])
    res['hs_ed25519_public_key'] = Puppet::Pops::Types::PSensitiveType::Sensitive.new(res['hs_ed25519_public_key'])
    res
  end

  def all_files_exist?(path)
    (onionv3_str_filenames|onionv3_bin_filenames).all?{|f| File.readable?(File.join(path,f)) }
  end

  def read_data(path)
    data = onionv3_str_filenames.inject({}) do |res,f|
      res[f] = File.read(File.join(path,f)).chomp
      res
    end
    onionv3_bin_filenames.inject(data) do |res,f|
      res[f] = call_function('binary_file',File.join(path,f))
      res
    end
  end

  def onionv3_str_filenames
    @onionv3_str_filenames ||= [
      'hostname'
    ]
  end
  def onionv3_bin_filenames
    @onionv3_bin_filenames ||=[ 'hs_ed25519_secret_key',
      'hs_ed25519_public_key',
    ]
  end

  def generate_data(path)
    key = Ed25519::SigningKey.generate
    pubkey = key.keypair[32...64]
    onionname = onion_address(pubkey)
    seckey = key.keypair[0...32]
    extkey = extend_sk(seckey)

    write_tagged_file("#{path}/hs_ed25519_secret_key", 'ed25519v1-secret', extkey)
    write_tagged_file("#{path}/hs_ed25519_public_key", 'ed25519v1-public', pubkey)
    File.open("#{path}/hostname", 'w') {|f| f.write "#{onionname}\n" }
  end

  def onion_address(pk, vers=3.chr)
    pref = '.onion checksum'
    v = pref + pk + vers
    d = sha3_digest(v)
    a = pk + d[0..1] + vers
    Base32.encode(a).downcase + ".onion"
  end

  def extend_sk(sk)
    sk = Digest::SHA512.digest(sk)
    sk[0] = (sk[0].ord & 248).chr
    sk[31] = (sk[31].ord & 63).chr
    sk[31] = (sk[31].ord | 64).chr
    sk
  end

  def write_tagged_file(file, tag, key)
    File.open(file, 'wb') do |f|
      pref = "== #{tag}: type0 =="
      f.write pref
      (32-pref.bytesize).times { f.write 0.chr }
      f.write key
    end
  end

  # dispatch onto a different library based
  # on which environment we are running, as the
  # sha3 c-extension can't be used on jruby, but the
  # pure implementation delivers the same result
  def sha3_digest(v)
    if defined?(RUBY_ENGINE) && (RUBY_ENGINE == 'jruby')
      require 'sha3-pure-ruby'
      Digest::SHA3.new(256).digest(v)
    else
      require 'sha3'
      c = SHA3::Digest::SHA256.new()
      c.update(v)
      c.digest
    end
  end
end
