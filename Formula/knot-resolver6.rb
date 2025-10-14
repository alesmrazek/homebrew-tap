class KnotResolver6 < Formula
  include Language::Python::Virtualenv

  desc "DNS resolver scalable from huge resolver farms down to home network routers"
  homepage "https://www.knot-resolver.cz"
  url "https://secure.nic.cz/files/knot-resolver/knot-resolver-6.0.15.tar.xz"
  sha256 "28195f681c00913a16c701c160798e4a28e88af1524351e1a55552b508bf4144"
  license all_of: ["CC0-1.0", "GPL-3.0-or-later", "LGPL-2.1-or-later", "MIT"]
  head "https://gitlab.labs.nic.cz/knot/knot-resolver.git", branch: "master"

  livecheck do
    url "https://www.knot-resolver.cz/download/"
    regex(/href=.*?knot-resolver[._-]v?(\d+(?:\.\d+)+)\.t[^>]*?>[^<]*?early-access/i)
  end

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
    url "https://files.pythonhosted.org/packages/62/f1/8515650ac3121a9e55c7b217c60e7fae3e0134b5acfe65691781b5356929/aiohttp-3.13.0.tar.gz"
    sha256 "378dbc57dd8cf341ce243f13fa1fa5394d68e2e02c15cd5f28eae35a70ec7f67"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
    sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "supervisor" do
    url "https://files.pythonhosted.org/packages/a9/b5/37e7a3706de436a8a2d75334711dad1afb4ddffab09f25e31d89e467542f/supervisor-4.3.0.tar.gz"
    sha256 "4a2bf149adf42997e1bb44b70c43b613275ec9852c3edacca86a9166b27e945e"
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
    args = ["--default-library=static"]
    args << "-Dsystemd_files=enabled" if OS.linux?

    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    venv = virtualenv_install_with_resources without: ["prometheus-client", "watchdog"]
    venv.pip_install "prometheus-client" if build.with? "prometheus"
    venv.pip_install "watchdog" if build.with? "watchdog"
  end

  def post_install
    (var/"knot-resolver").mkpath
  end

  service do
    run [opt_sbin/"knot-resolver", "-c", etc/"knot-resolver/config.yaml", "-n"]
    require_root true
    working_dir var/"knot-resolver"
    input_path File::NULL
    log_path File::NULL
    error_log_path var/"log/knot-resolver.log"
  end

  test do
    assert_path_exists var/"knot-resolver"
    system sbin/"knot-resolver", "--version"
  end
end
