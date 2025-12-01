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

    const final_pair = rotations.reduce(([previous_position, previous_count], rotation) => {
        let new_position = (previous_position + rotation) % 100
        if (new_position < 0) new_position += 100

        let count = Math.floor(Math.abs(rotation) / 100)
        const delta = rotation % 100

        if (rotation > 0) {
            if (new_position !== previous_position + delta) {
                count += 1
            }
        }

        if (rotation < 0) {
            if (previous_position !== 0 && new_position !== previous_position + delta) {
                count += 1
            }
            if (new_position === 0 && (previous_position + delta) === 0) {
                count += 1
            }
        }

        const new_count = previous_count + count

        console.log(`${previous_position} + ${rotation} = ${previous_position + rotation} -> ${new_position} (${count}) -> [${new_position}, ${new_count}]`)

        return [new_position, new_count]
    }, [50, 0])

    const total = final_pair[1]
    console.log(`Total: ${total}`)
})
