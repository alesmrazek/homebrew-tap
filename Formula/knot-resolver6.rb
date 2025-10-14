class KnotResolver6 < Formula
  include Language::Python::Virtualenv

  desc "DNS resolver scalable from huge resolver farms down to home network routers"
  homepage "https://www.knot-resolver.cz"
  url "https://gitlab.labs.nic.cz/knot/knot-resolver.git", branch: "manager-macos"
  version "6.0.16"
  license "GPL-3.0-or-later"

  conflicts_with "knot-resolver", because: "Versions 5 and 6 of Knot Resolver cannot be installed simultaneously."

  bottle do
    sha256 arm64_tahoe:   "6eba212c347984073fc9d40e134202867ae0cbfb8e25cd247b5943335ae86e2f"
    sha256 arm64_sequoia: "125e0626c3a093255a706cfd558ee53c75cec4adfa08e1f001c214c6d37a15a6"
    sha256 arm64_sonoma:  "ddaeaf61ebbec2f0f02c63552c1e53cf341b36a89484873a4594d04417ed12d0"
    sha256 sonoma:        "4b83b4b7c1f48bce2dd0e3a8d6fd854c4d57dac8addeafa93ee59693b6c35709"
    sha256 arm64_linux:   "a44b90de3037d1f0247dbf2d94455f81ba45ffe332335a6075e1c0b3b559a0e9"
    sha256 x86_64_linux:  "5da6935c2d96ed81f408b87a859613a16e730ff1a616b56350eca31a59951310"
  end

  option "with-prometheus", "Enable optional prometheus features"
  option "with-watchdog", "Enable optional watchdog features"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "fstrm"
  depends_on "gnutls"
  depends_on "knot"
  depends_on "libnghttp2"
  depends_on "libuv"
  depends_on "libyaml"
  depends_on "lmdb"
  depends_on "luajit"
  depends_on "protobuf-c"

  depends_on "python@3.13"

  on_linux do
    depends_on "libcap-ng"
    depends_on "libedit"
    depends_on "systemd"
  end

  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/1c/ce/3b83ebba6b3207a7135e5fcaba49706f8a4b6008153b4e30540c982fae26/aiohttp-3.13.2.tar.gz"
    sha256 "40176a52c186aefef6eb3cad2cdd30cd06e3afbe88fe8ab2af9c0b90f228daca"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/6b/5c/685e6633917e101e5dcb62b9dd76946cbb57c26e133bae9e0cd36033c0a9/attrs-25.4.0.tar.gz"
    sha256 "16d5969b87f0859ef33a48b35d55ac1be6e42ae49d5e853b597db70c35c57e11"
  end

  resource "multidict" do
    url "https://files.pythonhosted.org/packages/80/1e/5492c365f222f907de1039b91f922b93fa4f764c713ee858d235495d8f50/multidict-6.7.0.tar.gz"
    sha256 "c6e99d9a65ca282e578dfea819cfa9c0a62b2499d8677392e09feaf305e9e6f5"
  end

  resource "async-timeout" do
    url "https://files.pythonhosted.org/packages/a5/ae/136395dfbfe00dfc94da3f3e136d0b13f394cba8f4841120e34226265780/async_timeout-5.0.1.tar.gz"
    sha256 "d9321a7a3d5a6a5e187e824d2fa0793ce379a202935782d555d6e9d2735677d3"
  end

  resource "yarl" do
    url "https://files.pythonhosted.org/packages/57/63/0c6ebca57330cd313f6102b16dd57ffaf3ec4c83403dcb45dbd15c6f3ea1/yarl-1.22.0.tar.gz"
    sha256 "bebf8557577d4401ba8bd9ff33906f1376c877aa78d1fe216ad01b4d6745af71"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/6f/6d/0703ccc57f3a7233505399edb88de3cbd678da106337b9fcde432b65ed60/idna-3.11.tar.gz"
    sha256 "795dafcc9c04ed0c1fb032c2aa73654d8e8c5023a7df64a53f39190ada629902"
  end

  resource "propcache" do
    url "https://files.pythonhosted.org/packages/9e/da/e9fc233cf63743258bff22b3dfa7ea5baef7b5bc324af47a0ad89b8ffc6f/propcache-0.4.1.tar.gz"
    sha256 "f48107a8c637e80362555f37ecf49abe20370e557cc4ab374f04ec4423c97c3d"
  end

  resource "aiohappyeyeballs" do
    url "https://files.pythonhosted.org/packages/26/30/f84a107a9c4331c14b2b586036f40965c128aa4fee4dda5d3d51cb14ad54/aiohappyeyeballs-2.6.1.tar.gz"
    sha256 "c3f9d0113123803ccadfdf3f0faa505bc78e6a72d1cc4806cbd719826e943558"
  end

  resource "aiosignal" do
    url "https://files.pythonhosted.org/packages/61/62/06741b579156360248d1ec624842ad0edf697050bbaf7c3e46394e106ad1/aiosignal-1.4.0.tar.gz"
    sha256 "f47eecd9468083c2029cc99945502cb7708b082c232f9aca65da147157b251c7"
  end

  resource "frozenlist" do
    url "https://files.pythonhosted.org/packages/2d/f5/c831fac6cc817d26fd54c7eaccd04ef7e0288806943f7cc5bbf69f3ac1f0/frozenlist-1.8.0.tar.gz"
    sha256 "3ede829ed8d842f6cd48fc7081d7a41001a56f1f38603f9d49bf3020d59a31ad"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
    sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7/markupsafe-3.0.3.tar.gz"
    sha256 "722695808f4b6457b320fdc131280796bdceb04ab50fe1795cd540799ebe1698"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "supervisor" do
    url "https://files.pythonhosted.org/packages/a9/b5/37e7a3706de436a8a2d75334711dad1afb4ddffab09f25e31d89e467542f/supervisor-4.3.0.tar.gz"
    sha256 "4a2bf149adf42997e1bb44b70c43b613275ec9852c3edacca86a9166b27e945e"
  end

  resource "meld3" do
    url "https://files.pythonhosted.org/packages/64/34/7a43890031d05b2d3ed269ea6fa256016a8675f2420255caf22bf33bff98/meld-1.0.2.tar.gz"
    sha256 "696f67d4e88fc51f07463dcf96d3195734d1e3464c55ee95ebed2cf1c38134e9"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  resource "prometheus-client" do
    url "https://files.pythonhosted.org/packages/23/53/3edb5d68ecf6b38fcbcc1ad28391117d2a322d9a1a3eff04bfdb184d8c3b/prometheus_client-0.23.1.tar.gz"
    sha256 "6ae8f9081eaaaf153a2e959d2e6c4f4fb57b12ef76c8c7980202f1e57b48b2ce"
  end

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/db/7d/7f3d619e951c88ed75c6037b246ddcf2d322812ee8ea189be89511721d54/watchdog-6.0.0.tar.gz"
    sha256 "9ddf7c82fda3ae8e24decda1338ede66e1c99883db93711d8fb941eaa2d8c282"
  end

  def install
    args = ["--default-library=static", "--prefix=#{var}"]
    args << "-Dsystemd_files=enabled" if OS.linux?

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    venv = virtualenv_install_with_resources without: ["prometheus-client", "watchdog"]
    venv.pip_install "prometheus-client" if build.with? "prometheus"
    venv.pip_install "watchdog" if build.with? "watchdog"

    (bin/"knot-resolver").unlink if (bin/"knot-resolver").exist?
    (bin/"knot-resolver").write_env_script libexec/"bin/knot-resolver",
      PATH: "#{libexec}/bin:$PATH"

    (buildpath/"config.yaml").write(config_yaml)
    (etc/"knot-resolver").install "config.yaml"
  end

  def config_yaml
    <<~EOS
      workers: 1
      rundir: #{var}/knot-resolver
      network:
        listen:
          - interface:
              - 127.0.0.1@5353
          cache:
        storage: #{var}/cache/knot-resolver
      management:
        unix-socket: #{var}/knot-resolver/kres-api.sock
    EOS
  end

  def post_install
    (var/"knot-resolver").mkpath
    (var/"cache/knot-resolver").mkpath
  end

  service do
    run [opt_bin/"knot-resolver", "-c", etc/"knot-resolver/config.yaml"]
    require_root true
    working_dir var/"knot-resolver"
    input_path File::NULL
    log_path File::NULL
    error_log_path var/"log/knot-resolver6.log"
  end

  test do
    assert_path_exists var/"knot-resolver"
    assert_path_exists var/"cache/knot-resolver"
    system bin/"kresctl", "--version"
    system bin/"knot-resolver", "--version"
  end
end
