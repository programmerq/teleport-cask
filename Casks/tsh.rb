cask "tsh" do
  version "8.3.2"
  sha256 "5489b98b1e13c225e208fae54ec4054806a140cff19bc3835a78954f963d77dc"

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
