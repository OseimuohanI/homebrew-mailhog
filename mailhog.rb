class Mailhog < Formula
  desc "Web and API based SMTP testing tool with dark mode and persistent storage"
  homepage "https://github.com/OseimuohanI/MailHog"
  version "2.0.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.8/MailHog-darwin-arm64"
      sha256 "12945c91d9393387d9fb9ab0549526f5947be913a6856b9ae42b4b8c0fceffd6"
    else
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.8/MailHog-darwin-amd64"
      sha256 "bdd19da0ca945d85459bdafbfe5698f3566c369a90fb28bb24054a7fa7a19aad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.8/MailHog-linux-arm64"
      sha256 "6e30fdabe27d697fb6c8ae8211faf15409bfd26a528ba6377b6dd2145b59390b"
    else
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.8/MailHog-linux-amd64"
      sha256 "18a64803b6deb3eb88b2132cb099175defba99490e0ba3a8a3824394d55efab1"
    end
  end

  def install
    bin.install "MailHog-darwin-arm64" => "MailHog" if OS.mac? && Hardware::CPU.arm?
    bin.install "MailHog-darwin-amd64" => "MailHog" if OS.mac? && Hardware::CPU.intel?
    bin.install "MailHog-linux-arm64" => "MailHog" if OS.linux? && Hardware::CPU.arm?
    bin.install "MailHog-linux-amd64" => "MailHog" if OS.linux? && Hardware::CPU.intel?
  end

  def caveats
    <<~EOS
      MailHog has been installed with custom features:
      
      🌙 Dark Mode: Toggle in the web UI (top-right corner)
      💾 Persistent Storage: Emails saved to ./MailHog/mailhog-data directory
      
      To start MailHog:
        mailhog
      
      SMTP server will run on: localhost:1025
      Web interface will run on: http://localhost:8025
      
      To run MailHog as a background service:
        brew services start mailhog
    EOS
  end

  service do
    run [opt_bin/"MailHog"]
    keep_alive true
    log_path var/"log/mailhog.log"
    error_log_path var/"log/mailhog.log"
  end

  test do
    system "#{bin}/MailHog", "--version"
  end
end
