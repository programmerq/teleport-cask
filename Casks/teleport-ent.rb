cask "teleport-ent" do
  version "7.1.2"
  sha256 "f1fc004e42ca9590412df15db9fbf6a4a80ff087505672d0fd4ec61c20367f1f"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: "teleport", cask: "tsh"

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
