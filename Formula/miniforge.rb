class Miniforge < Formula
  desc "Autonomous software factory — built on MiniForge Core"
  homepage "https://miniforge.ai"
  version "2026.04.26.1"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-macos-arm64"
    sha256 "0427edf693237e30a6e213e06b7adacacd6c33a1e1428a12505f76d46325317e"
  end

  on_linux do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.26.1/miniforge-linux-x86_64"
    sha256 "e0a092ff7f42f33d0942f55d2d000ea2f762c251b831e7917cea53cea251760e"
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
