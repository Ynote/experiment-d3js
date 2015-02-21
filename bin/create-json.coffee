require 'coffee-script/register'

list       = require './../data/list.json'
R          = require 'ramda'
Q          = require 'q'
fs         = require 'fs'
d3jsonPath = 'data/tags.json'
pair       = require './../lib/pair'
tags       = require './../lib/tags'

tagsList = R.pipe(
    R.map(R.prop('tags')),
    R.flatten,
    R.uniq
)(list.data)

tagsLinks = R.pipe(
    R.map(R.prop('tags')),
    R.map(tags.getIndexesFromList),
    R.map(pair.createFromList),
    R.map(pair.sort),
    R.unnest,
    R.uniqWith((a, b) -> return a.join('') == b.join('')),
    R.map(pair.createJsonEntry)
)(list.data)

tagsNodes = R.pipe(
    R.mapIndexed tags.createJsonEntry
)(tagsList)

d3json =
    nodes: tagsNodes
    links: tagsLinks

fs.writeFile d3jsonPath, JSON.stringify(d3json)
