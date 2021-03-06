should = require 'should'

describe "YANG Jukebox Example", ->
  juke = undefined
  before ->
    juke = (require './examples/jukebox').eval {
      jukebox:
        library: {}
        playlist: [
          {
            name: 'ellie playtime',
            description: 'tunes for toddler play'
          }
        ]
    }

  it 'should contain initial playlist', ->
    juke.should.have.property('jukebox')
    juke.jukebox.should.have.property('playlist')
    juke.jukebox.playlist.should.be.instanceof(Array).and.have.length(1)

  it 'should setup jukebox library', ->
    juke.jukebox.library =
      artist: [
        name: 'Super Simple Songs'
        album: [
          name: 'Animals Vol. 1'
          year: '2015'
          song: [
            name: 'old mcdonald had a farm'
            location: '/hard/wired/in/my/head.mpg'
          ]
        ]
      ]

  it 'should enable adding a song to the playlist', ->
    juke.jukebox.playlist['ellie playtime'].song = [
      index: 1
      id: 'old mcdonald had a farm'
    ]

  it 'should play the song', ->
    juke.play 
      playlist: 'ellie playtime',
      'song-number': 1
    .then (res) -> should(res).equal('ok')
