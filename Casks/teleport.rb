cask "teleport" do
  version "8.3.2"
  sha256 "6323a7b3fd0a1fd397b0cd2832eabacbc21fe123288e007029f21f35a2950b37"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API"
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "tsh"]

  caveats do
    license "Apache-2.0"
  end
end
