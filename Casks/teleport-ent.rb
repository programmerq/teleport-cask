cask "teleport-ent" do
  version "7.1.3"
  sha256 "bb6566c2ea9769aa3c20ce01abbd416bd55aa855fffb8da1ee32e2e0acfac1b5"

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
