PlayState = Class{__includes = BaseState}

-- constant array of words
WORDS = {"add", "multiply", "divide"}

LETTERS = 
{"a", "b", "c", "d", "e", "f",
"g", "h", "i", "j", "k", "l",
"m", "n", "o", "p", "q", "r",
"s", "t", "u", "v", "w", "x",
"y", "z"}

function PlayState:init()
	self.word = WORDS[math.random(#WORDS)] -- word chosen at random from constant WORDS
	self.stateOfWord = {} -- the state of the word visible to the user

	-- initialize the state of the word to be fully "_"
	for i = 1, #self.word do
		table.insert(self.stateOfWord, "_")
	end

	self.incorrectGuesses = 0 -- amount of guessIncorrect guesses
	self.correctGuesses = 0 -- amount of correct guesses
	self.victory = false -- variable to check whether the user has won

	self.guessedLetters = {} -- list that keeps track of the letters that the user has guessed
end

function PlayState:enter()
    -- nothing
end

function PlayState:update(dt)
	-- find the letter that the user has pressed 
	for i = 1, #LETTERS do 
		if love.keyboard.wasPressed(LETTERS[i]) then

			local letterIsInWord = {} -- array of booleans depending on if the guessed letter is in the word
			local guessedLettersThisRound = {} -- array of characters that adds a character every time it is found in the word
			
			-- check whether the letter was guessed before
			local letterAlreadyGuessed = false
			for y = 1, #self.guessedLetters do
				if self.guessedLetters[y] == LETTERS[i] then
					letterAlreadyGuessed = true
				end
			end

			-- if letter was already guessed, stop the function
			if letterAlreadyGuessed then
				return
			end

			-- if the guessed letter is in the word (correct guess)
			for x = 1, #self.word do
				if self.word:sub(x, x) == LETTERS[i] then

					-- replace the underscore in the array with the letter
					self.stateOfWord[x] = self.word:sub(x, x)

					-- if the letter was not guessed, increment the correct guesses and update the boolean array
					if not letterAlreadyGuessed then
						self.correctGuesses = self.correctGuesses + 1
						letterIsInWord[x] = true
					end

					-- insert the guessed letter to the table of guessed letters
					table.insert(guessedLettersThisRound, LETTERS[i])

				-- if the guessed letter is not in the word
				else
					letterIsInWord[x] = false
				end
			end

			-- check whether the guess was incorrect
			local guessIncorrect = true

			-- if the array of booleans doesn't have a 'true' value, then the guess was incorrect
			for x = 1, #letterIsInWord do
				if letterIsInWord[x] == true then
					guessIncorrect = false
				end
			end

			-- if the guess was incorrect, increment the number of incorrect guesses
			if guessIncorrect then
				self.incorrectGuesses = self.incorrectGuesses + 1

				-- insert the guessed letter to the table of guessed letters
				table.insert(guessedLettersThisRound, LETTERS[i])

				-- if the number of incorrect guesses is 6, the user has lost
				if self.incorrectGuesses == 6 then
					self.victory = false
					gStateMachine:change('gameover', {
						victory = self.victory
						})
				end
			end

			print(self.incorrectGuesses)

			-- if the number of correct guesses is equal to the length of the word, the user has won
			if self.correctGuesses == #self.word then
				self.victory = true
				gStateMachine:change('gameover', {
						victory = self.victory
						})
			end

			-- if the number of correct letters is greater than 0, insert the letter into the guessed characters into the array
			if #guessedLettersThisRound > 0 then
				table.insert(self.guessedLetters, guessedLettersThisRound[1])
			end
		end
	end
end

function PlayState:render()
    for i = 1, #self.stateOfWord do
    	love.graphics.printf(self.stateOfWord[i], 40 + (i - 1) * 16, 208, VIRTUAL_WIDTH)
    end

    if self.incorrectGuesses >= 1 then
		love.graphics.circle('line', VIRTUAL_WIDTH / 2, 50, 30, 100)
	end

	if self.incorrectGuesses >= 2 then
		love.graphics.line(VIRTUAL_WIDTH / 2, 80, VIRTUAL_WIDTH / 2, 130)
	end

	if self.incorrectGuesses >= 3 then
		love.graphics.line(VIRTUAL_WIDTH / 2, 90, VIRTUAL_WIDTH / 2 - 15, 110)
	end

	if self.incorrectGuesses >= 4 then
		love.graphics.line(VIRTUAL_WIDTH / 2, 90, VIRTUAL_WIDTH / 2 + 15, 110)
	end

	if self.incorrectGuesses >= 5 then
		love.graphics.line(VIRTUAL_WIDTH / 2, 130, VIRTUAL_WIDTH / 2 - 15, 150)
	end

	if self.incorrectGuesses >= 6 then
		love.graphics.line(VIRTUAL_WIDTH / 2, 130, VIRTUAL_WIDTH / 2 + 15, 150)
	end
end

function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

function PlayState:exit()
    -- nothing
end

