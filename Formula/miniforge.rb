class Miniforge < Formula
  desc "Autonomous SDLC platform - convert intent to production software"
  homepage "https://miniforge.ai"
  version "2026.01.21.3"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.01.21.3/miniforge-macos-arm64"
    sha256 "954ae562720ab6517a56aa6cbdbe5524a3cabe46a37ca4f78dda2d75021fd195"
  end

  on_linux do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.01.21.3/miniforge-linux-x86_64"
    sha256 "954ae562720ab6517a56aa6cbdbe5524a3cabe46a37ca4f78dda2d75021fd195"
  end

  depends_on "babashka"
  depends_on "gum"

  def install
    bin.install "miniforge-macos-arm64" => "mf" if OS.mac?
    bin.install "miniforge-linux-x86_64" => "mf" if OS.linux?
  end

  test do
    assert_match "miniforge", shell_output("#{bin}/mf version")
  end
end
