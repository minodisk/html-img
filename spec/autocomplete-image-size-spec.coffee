{WorkspaceView} = require 'atom'
AutocompleteImageSize = require '../lib/autocomplete-image-size'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AutocompleteImageSize", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('autocomplete-image-size')

  describe "when the autocomplete-image-size:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.autocomplete-image-size')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'autocomplete-image-size:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.autocomplete-image-size')).toExist()
        atom.workspaceView.trigger 'autocomplete-image-size:toggle'
        expect(atom.workspaceView.find('.autocomplete-image-size')).not.toExist()
