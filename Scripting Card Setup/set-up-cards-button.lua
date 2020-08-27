DECK_GUID = Global.getVar('DECK_GUID')

function setUpCards()
    local deck = getObjectFromGUID(DECK_GUID)
    deck.shuffle()
    deck.deal(5)
    
    local deckPos = deck.getPosition()
    local xPos = deckPos[1] + 3
    for i = 1, 2 * #getSeatedPlayers() do
        deck.takeObject({flip=true, position={xPos, deckPos[2], deckPos[3]}})
        xPos = xPos + 3
    end

    destroyObject(self)
end
