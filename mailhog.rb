class Mailhog < Formula
  desc "Web and API based SMTP testing tool with dark mode and persistent storage"
  homepage "https://github.com/OseimuohanI/MailHog"
  version "2.0.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.6/MailHog-darwin-arm64"
      sha256 "67c43aa82a31a6c9b66257016071f07c2646b711cdd096e2677cac780e395916"
    else
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.6/MailHog-darwin-amd64"
      sha256 "5ff61cca517545d5afe773b7dd3fbd7b2c67c5eae4bebb692609361623f33b74"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.6/MailHog-linux-arm64"
      sha256 "772331e465b8d3f958ef9f324638438feaf9113f3c4005d36b823186248da63c"
    else
      url "https://github.com/OseimuohanI/MailHog/releases/download/v2.0.6/MailHog-linux-amd64"
      sha256 "657c3a7e0ef760fcc528d47772a45dc1ebbe9c7cc96c808c521bfe67f8b1f155"
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
      💾 Persistent Storage: Emails saved to ./mailhog-data directory
      
      To start MailHog:
        mailhog
      
      SMTP server will run on: localhost:1025
      Web interface will run on: http://localhost:8025
      
      To run MailHog as a background service:
        brew services start mailhog
    EOS
  end

  service do
    run [opt_bin/"MailHog", "-maildir-path", var/"mailhog/data"]
    keep_alive true
    log_path var/"log/mailhog.log"
    error_log_path var/"log/mailhog.log"
  end

  test do
    system "#{bin}/MailHog", "--version"
  end
end
