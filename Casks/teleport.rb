cask "teleport" do
  module Utils
    def self.version
      return "14.3.1"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/teleport-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API."
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "teleport-ent@13.0", "teleport-ent@12.0", "teleport-ent@11.0"]

  caveats do
    license "Apache-2.0"
  end
end
