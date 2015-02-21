R = require('ramda')

pair =
    diff: R.curry((a, b) ->
        a - b
    )

    sort: R.curry((pair) ->
        R.map(
            R.sort(pair.diff),
            pair
        )
    )

    createJsonEntry: R.curry((pair) ->
        source: pair[0]
        target: pair[1]
    )

    toArray: R.curry( (a, b) ->
        [a, b]
    )

    createFromList: R.curry((list) ->
        if list.length < 2
            return []

        first  = R.head(list)
        sliced = R.tail(list)
        pairs = R.map((x) -> pair.toArray(x, first))(sliced)
        next =  pair.createFromList(sliced)


        R.concat(pairs, pair.createFromList(sliced))
    )

module.exports = pair
