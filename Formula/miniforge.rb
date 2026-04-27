class Miniforge < Formula
  desc "Autonomous software factory — built on MiniForge Core"
  homepage "https://miniforge.ai"
  version "2026.04.26.1"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-macos-arm64"
    sha256 "98f1a3b067f022aa40f4b47050117a98a572968f30a0e0cc1ea46532d6138787"
  end

  on_linux do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-linux-x86_64"
    sha256 "c4b4a5ab8df8d748110de2592742e8482e681c619d30b079c843dd6a63d1e525"
  end

  depends_on "babashka"

  def install
    jar_name = "miniforge.jar"
    if OS.mac?
      libexec.install "miniforge-macos-arm64" => jar_name
    else
      libexec.install "miniforge-linux-x86_64" => jar_name
    end

    (bin/"mf").write <<~SH
      #!/bin/bash
      exec bb --jar "#{libexec}/#{jar_name}" -m ai.miniforge.cli.main "$@"
    SH
  end

  test do
    assert_match "miniforge", shell_output("#{bin}/mf --help 2>&1")
  end
end
