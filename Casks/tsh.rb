cask "tsh" do
  version "7.1.2"
  sha256 "a0d67d2cecfa3ecb91e1fa224f0053b13a5667d817596431e1e894f8ead08075"

  url "https://get.gravitational.com/tsh-#{version}.pkg",
      verified: "get.gravitational.com"
  name "tsh"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. TSH client only"
  homepage "https://goteleport.com/"
  pkg "tsh-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport.tsh"
  ]

  conflicts_with formula: "teleport", cask: "teleport-ent", cask: "teleport"

  caveats do
    license "Apache-2.0"
  end
end
