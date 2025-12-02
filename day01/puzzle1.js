#!/usr/bin/env node

import fs from 'node:fs'

const LINE_REGEX = /(?<direction>[LR])(?<distance>\d+)/

// fs.readFile('sample.txt', 'utf8', (err, data) => {
fs.readFile('input.txt', 'utf8', (err, data) => {
    if (err) {
        console.error(err)
        return
    }

    const lines = data.split('\n').filter(s => s)

    console.log('lines')
    console.log(lines)
    console.log()

    const rotations = lines
        .map(line => line.match(LINE_REGEX))
        .map(match => ({ direction: match.groups.direction, distance: Number(match.groups.distance) }))
        .map(({ direction, distance }) => (direction === 'R') ? distance : -distance)

    console.log('rotations')
    console.log(rotations)
    console.log()

    const positions = rotations.reduce((acc, distance) => {
        const previous_position = acc.at(-1)
        let new_position = (previous_position + distance) % 100
        if (new_position < 0) {
            new_position += 100
        }
        acc.push(new_position)
        return acc
    }, [50])

    console.log('positions')
    console.log(positions)
    console.log()

    const total = positions.filter(position => position === 0).length
    console.log(`Total: ${total}`)
})
