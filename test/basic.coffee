assert = require 'assert'
should = require 'should'
{exec} = require 'child_process'

describe 'sanity check', ->
  it 'should pass', ->
    assert 1 + 1 == 2

describe 'code-stats', ->

  describe 'code-stats <paths>', ->
    it 'should show line counts for each type', (done) ->
      exec './code-stats test/fixtures', (err, stdout, stderr) ->
        should.not.exist err
        expected = """

           Filetype | Line count
          -----------------------
                 js | 1000
                  c | 900
                 rb | 800
                 py | 700
               java | 600
          ~~~~~~~~~~~~~~~~~~~~~~~
                All | 4000

          """
        stdout.should.equal expected
        done()

  describe '-x, --exclude <pattern>', ->
    it 'should exclude files in addition to defaults', (done) ->
      exec "./code-stats -x 'js|java' test/fixtures", (err, stdout, stderr) ->
        should.not.exist err
        expected = """

           Filetype | Line count
          -----------------------
                  c | 900
                 rb | 800
                 py | 700
          ~~~~~~~~~~~~~~~~~~~~~~~
                All | 2400

          """
        stdout.should.equal expected
        done()
