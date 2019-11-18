class StellarCore < Formula
  desc "The backbone of the Stellar (XLM) network"
  homepage "https://www.stellar.org/"
  url "https://github.com/stellar/stellar-core.git",
      :tag      => "v12.1.0",
      :revision => "8afe57913a08deffa247d7b5f837e0b28a54b864"
  head "https://github.com/stellar/stellar-core.git"

  bottle do
    cellar :any
    sha256 "9d4fa1d80bf3803ac1cfead0aaf8fa780bee23a382b49a81953a7d3f941220f9" => :mojave
    sha256 "70716934cee9618b1f8a0ff3a72cdec517605801fcaeae011fe8dd6aac2fe948" => :high_sierra
    sha256 "40a543065df367936af776a46ff876c3f70c3443e7703e34b9ad8449e6ae724a" => :sierra
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pandoc" => :build
  depends_on "pkg-config" => :build
  depends_on "parallel" => :test
  depends_on "libpqxx"
  depends_on "libsodium"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-postgres"
    system "make", "install"
  end

  test do
    system "#{bin}/stellar-core", "test", "'[bucket],[crypto],[herder],[upgrades],[accountsubentriescount],[bucketlistconsistent],[cacheisconsistent],[fs]'"
  end
end
