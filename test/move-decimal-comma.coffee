{ equal: eq } = require 'assert'
move = require '../index.coffee'

describe 'move-decimal-comma', ->
  it 'can move it to the right', ->
    eq (move '123,456789', 2, ','), '12345,6789'
    eq (move '123,456789', 4, ','), '1234567,89'
    eq (move '123,456789', 6, ','), '123456789'
    eq (move '123,456789', 7, ','), '1234567890'
    eq (move '123,456789', 9, ','), '123456789000'

    eq (move '123', 1, ','), '1230'
    eq (move '123', 2, ','), '12300'

  it 'can move it to the left', ->
    eq (move '123456,789', -2, ','), '1234,56789'
    eq (move '123456,789', -4, ','), '12,3456789'
    eq (move '123456,789', -6, ','), '0,123456789'
    eq (move '123456,789', -7, ','), '0,0123456789'
    eq (move '123456,789', -9, ','), '0,000123456789'

    eq (move '123', -1, ','), '12,3'
    eq (move '123', -2, ','), '1,23'
    eq (move '123', -3, ','), '0,123'
    eq (move '1230', -1, ','), '123'
    eq (move '1230', -2, ','), '12,3'

  it 'works on negative numbers', ->
    eq (move '-9', -2, ','), '-0,09'
    eq (move '-123', 1, ','), '-1230'
    eq (move '-123', -1, ','), '-12,3'
    eq (move '-123,45', 2, ','), '-12345'
    eq (move '-123,45', -2, ','), '-1,2345'

  it 'is a noop for n=0', ->
    eq (move '123,456', 0, ','), '123,456'

  it 'works on random numbers', ->
    for [1..1000]
      num = Math.random() * 1000000
      num = num | 0  if Math.random()<=0.5
      num = num * -1 if Math.random()<=0.5
      n = -10 + (Math.random()*20|0)

      eq move(move(num,n, ','), n*-1, ','), num
    return
