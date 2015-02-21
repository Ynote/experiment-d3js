list       = require './../data/list.json'
R          = require 'ramda'

tags =
    getList: ->
        R.pipe(
            R.map(R.prop('tags')),
            R.flatten,
            R.uniq
        )(list.data)

    getIndexesFromList: R.curry((list) ->
        R.pipe(
            R.map((x) -> return R.indexOf(x, tags.getList()))
        )(list)
    )

    createJsonEntry: R.curry((x, i) ->
        name: x
        id: i
    )

module.exports = tags
