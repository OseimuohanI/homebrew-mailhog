class Mailhog < Formula
  desc "SMTP capture and email testing with a web interface"
  homepage "https://github.com/OseimuohanI/MailHog"
  version "2.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.1.0/MailHog-darwin-arm64"
      sha256 "9dd6e6cd62b56e84958c69c32f178400424358efee39a6b02e057d5431475f8f"
    else
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.1.0/MailHog-darwin-amd64"
      sha256 "94b82c4fe2c5a409beb7f88bdd94f1f0734cfb7556f05eb58d548cae587ec0ad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.1.0/MailHog-linux-arm64"
      sha256 "58aaa45cc1fe2d511ab7965039f91e28cc6d812df2bca564c9147f1a5638144d"
    else
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.1.0/MailHog-linux-amd64"
      sha256 "346374433138dc6cfbe529ffb800eec8865c5ae3214a7c74a472177082f1c291"
    end
  end

  def install
    bin.install "MailHog-darwin-arm64" => "MailHog" if OS.mac? && Hardware::CPU.arm?
    bin.install "MailHog-darwin-amd64" => "MailHog" if OS.mac? && Hardware::CPU.intel?
    bin.install "MailHog-linux-arm64" => "MailHog" if OS.linux? && Hardware::CPU.arm?
    bin.install "MailHog-linux-amd64" => "MailHog" if OS.linux? && Hardware::CPU.intel?
    bin.install_symlink "MailHog" => "mailhog" unless (bin/"mailhog").exist?
  end

  def caveats
    <<~EOS
      Start MailHog with:
        mailhog

      SMTP: localhost:1025
      Web interface: http://localhost:8025
      Messages: ~/MailHog/mailhog-data
      Settings and labels: ~/MailHog/mailhog-state

      Select a theme in Settings. Testing tools are available in the header.

      To run MailHog as a background service:
        brew services start OseimuohanI/mailhog/mailhog
    EOS
  end

  service do
    run [opt_bin/"MailHog"]
    keep_alive true
    log_path var/"log/mailhog.log"
    error_log_path var/"log/mailhog.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mailhog --version")
  end
end
