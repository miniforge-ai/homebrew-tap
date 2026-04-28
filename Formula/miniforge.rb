class Miniforge < Formula
  desc "Autonomous software factory — built on MiniForge Core"
  homepage "https://miniforge.ai"
  version "2026.04.26.1"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-macos-arm64"
    sha256 "02d36ed11412957c6557d7dd7006ac4b8c649bd15bb647f3c7e6e204debdf9b7"
  end

  on_linux do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-linux-x86_64"
    sha256 "eba632196cbd224b6f42c8f4c7bee9fd5e72bef9871a18890b9a2af0d639b18f"
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
