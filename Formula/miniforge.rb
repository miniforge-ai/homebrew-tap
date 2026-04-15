class Miniforge < Formula
  desc "Autonomous software factory — built on MiniForge Core"
  homepage "https://miniforge.ai"
  version "2026.04.14.2"
  license "Apache-2.0"

  on_macos do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.14.2/miniforge-macos-arm64"
    sha256 "c828505a150d3600295c65e0ab32330eb4cf3a541ca384faeb320803c08b311a"
  end

  on_linux do
    url "https://github.com/miniforge-ai/miniforge/releases/download/v2026.04.14.2/miniforge-linux-x86_64"
    sha256 "2ae7109ad1b42007184be10d29168c5cd001125772785361424eb96eec44d3e4"
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
