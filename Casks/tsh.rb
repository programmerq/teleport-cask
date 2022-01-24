cask "tsh" do
  version "8.1.0"
  sha256 "8462e56e4828c6092d6bd001c163f747d1a2297965f8eb2aaa0695c9ed7f07ee"

  url "https://get.gravitational.com/tsh-#{version}.pkg",
      verified: "get.gravitational.com"
  name "tsh"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. TSH client only"
  homepage "https://goteleport.com/"
  pkg "tsh-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport.tsh"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "teleport"]

  caveats do
    license "Apache-2.0"
  end
end
