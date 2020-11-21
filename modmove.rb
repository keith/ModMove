cask 'modmove' do
  version '1.1.0'
  sha256 '7e6890beeea2a4e2a19656b6e09986b1a77b044f179bb62a59cff05fec4b31f9'

  url "https://github.com/keith/modmove/releases/download/#{version}/ModMove.app.zip"
  appcast 'https://github.com/keith/modmove/releases.atom'
  name 'ModMove'
  homepage 'https://github.com/keith/modmove'
  license :mit

  app 'ModMove.app'
end
