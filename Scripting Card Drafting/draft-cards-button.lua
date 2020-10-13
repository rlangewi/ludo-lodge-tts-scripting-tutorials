DEBUG = false
ALL_PLAYERS = {"White", "Red", "Orange", "Yellow",
               "Green", "Blue", "Purple", "Pink"}

passInProgress = false

function passCardsClockwise()
    if not passInProgress then
        passInProgress = true
        passCardsWrapper(true)
    end
end

function passCardsCounterClockwise()
    if not passInProgress then
        passInProgress = true
        passCardsWrapper(false)
    end
end

function passCardsWrapper(clockwise)
    function passCardsCoroutine()
        sortedSeatedPlayers = {} 

        for _, color in ipairs(ALL_PLAYERS) do
            if DEBUG or Player[color].seated then
                table.insert(sortedSeatedPlayers, color)
            end
        end

        for index, color in ipairs(sortedSeatedPlayers) do
            local target = nil

            if clockwise then
                if index < #sortedSeatedPlayers then
                    target = sortedSeatedPlayers[index+1]
                else
                    target = sortedSeatedPlayers[1]
                end
            else
                if index > 1 then
                    target = sortedSeatedPlayers[index-1]
                else
                    target = sortedSeatedPlayers[#sortedSeatedPlayers]
                end
            end

            local playerHand = Player[color].getHandObjects()

            for _, item in ipairs(playerHand) do
                if item.tag == 'Card' then
                    item.deal(1, target)
                end
            end

            coroutine.yield(0)
        end

        passInProgress = false
        return 1
    end

    startLuaCoroutine(self, 'passCardsCoroutine')
end

