DEBUG = true
ALL_PLAYERS = {"White", "Red", "Orange", "Yellow",
               "Green", "Blue", "Purple", "Pink"}
ALL_PLAYERS_REVERSED = {"Pink", "Purple", "Blue", "Green",
                        "Yellow", "Orange", "Red", "White"}

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
        local sortedSeatedPlayers = {}
        
        local playerOrder = ALL_PLAYERS
        if not clockwise then
            playerOrder = ALL_PLAYERS_REVERSED
        end

        for _, color in ipairs(playerOrder) do
            if DEBUG or Player[color].seated then
                table.insert(sortedSeatedPlayers, color)
            end
        end

        for index, color in ipairs(sortedSeatedPlayers) do
            local target = nil

            if index < #sortedSeatedPlayers then
                target = sortedSeatedPlayers[index + 1]
            else
                target = sortedSeatedPlayers[1]
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
