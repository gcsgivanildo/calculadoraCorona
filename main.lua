-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--Plano de fundo
ret = display.newRect(0, 0, display.contentWidth * 2, display.contentHeight * 2.2)
ret:setFillColor( 0, 0, 250 )

-------------------------------------
-------------------------------------
--class do controler da calculadora
local cc = require ("calcController")

--Variaveis
local displayStr = "0"

--limite numeros digitados
local maxDigits = 13

--tipo de botao digitados
--aceita "none", "equal", "num" ou "math"
local lastInput = "none"

--começa a captura de um novo dígito
--quando um decimal ou digito são precionados
local startNewNumber = true

--último botao precionado foi "-"
local negPressedLast = false

--botao decimal precionado
local decimalPressed = false

-------------------------------------
-------------------------------------
--tela da calculadora
local calcScr = native.newTextField(display.contentWidth * .5,
				display.contentHeight * 0.5 - 200, 250, 40)
calcScr.inputType = "number"
calcScr.text = "left"
calcScr.text = string.lower(displayStr)
calcScr:setTextColor( 250, 0, 0 )
 
-------------------------------------
-------------------------------------

-------------------------------------
-------------------------------------

--lida com os botões de matemática ( '+', '-', '/', 'X', '=', %,  )
local function mathBtnTapped( event )
	if (event.phase == "ended") then
		local targetID = event.target.id

		if targetID == "-" and startNewNumber then
			negPressedLast = true
		else
			negPressedLast = false
		end	

		--se o '=' não for a primeira vez em uma linha
		if lastInput ~= "equal" then
			cc.setOp2(tonumber(displayStr))
		end

		if targetID ~= "=" and lastInput == "equal" then

			cc.setOp1(tonumber(displayStr))
			cc.setOp2(0)
		else 
			cc.performOperation()
		end 

		displayStr = cc.getOp1()

		if targetID == "=" then
			lastInput = "equal"
		else
			lastInput = "math"
		end

		--seta a última função digitada (%,X, /, -, +)
		cc.setOperador(targetID)

		--checando os erros
		if cc.foundError then 
			displayStr = "ERROR"
		end

		 --botao Limpar
		 if targetID == "c" then
		 	cc.clear()
		 	displayStr = cc.getOp1()
		 end
		 

		 --mostrar o operador1 na tela de leitura
		 calcScr.text = string.lower(displayStr)
		 
			return true
	end
end


--lida com os botões numéricos ( '0' - '9') 

local function numBtnTapped( event )
	if("ended" == event.phase) then

		local targetID = event.target.id

		if lastInput =="equal" then
			clear()
		elseif lastInput ~= "num" then
			displayStr = "0"
			dicimalPressed = false
		end

		--não permitir a exibição maior que 'maxDigits'
		if (string.len(displayStr) < maxDigits) then
			displayStr = displayStr .. targetID
		end
	 	-- verifique se o botão "-" foi pressionado antes deste número
	 	if negPressedLast then
	 		displayStr = "-" ..displayStr
	 		negPressedLast = true
	 	end

	 	--último botão foi um botão numérico
	 	lastInput = "num"

	 	-- limpa '0' no lado equerdo da seqüência de leitura
	 	displayStr = displayStr - 0
	 	displayStr = displayStr
	 	calcScr.text = string.lower(displayStr)
	    startNewNumber = false
		return true
	end
end


--trata do botão decimal ('.')
local function decimalBtnTapped( event )
	if("ended" == event.phase) then
		local targetID = event.target.id
		--resetar a seqüência de leitura, se esta for uma nova seqüência de dígitos para entrar
		--Se lastinput foi "equal" entao iniciamos uma nova sequencia
		--sentao chamamos clear()
		if lastInput =="equal" then
			clear()
		elseif lastInput ~= "num" then
			displayStr = "0"
			dicimalPressed = false
		end

		if not decimalPressed and (string.len(displayStr) < maxDigits) then
			displayStr = displayStr.."."
			decimalPressed = true
			lastInput = "num"
		end
		calcScr.text = string.lower(displayStr)
		return true
	end
end

-------------------------------------
-------------------------------------

--=======================================
--Butões
--=======================================
local widget = require("widget")
local btn0 = widget.newButton( {
	--left = 25,
	--top = 360,
	x = display.contentWidth * 0.41 - 55,
	y = display.contentHeight * 0.5 + 110,
	label = 0,	
	id = 0,
	fontSize =30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped  
	} )

local btn1 = widget.newButton( {
	--left = 25,
	--top = 305,
	x = display.contentWidth * 0.41 - 55,
	y = display.contentHeight * 0.5 + 55,
	label = 1,	
	id = 1,
	fontSize =30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn2 = widget.newButton( {
	--left = 80,
	--top = 305,
	x = display.contentWidth * 0.41,
	y = display.contentHeight * 0.5 + 55,
	label = 2,	
	id = 2,
	fontSize =30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn3 = widget.newButton( {
	--left = 135,
	--top = 305,
	x = display.contentWidth * 0.41 + 55,
	y = display.contentHeight * 0.5 + 55,
	label = 3,	
	id = 3,
	fontSize =30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn4 = widget.newButton( {
	--left = 25,
	--top = 250,
	label = 4,
	x = display.contentWidth * 0.41 - 55,
	y = display.contentHeight * 0.5,
	fontSize =30,
	id = 4,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn5 = widget.newButton( {
	--left = 80,
	--top = 250,
	x = display.contentWidth * 0.41,
	y = display.contentHeight * 0.5,
	label = 5,
	fontSize =30,
	id = 5,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn6 = widget.newButton( {
	label = 6,
	id = 6,
	--left = 135,
	--top = 250,
	x = display.contentWidth * 0.41 + 55,
	y = display.contentHeight * 0.5,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn7 = widget.newButton( {
	label = 7,
	id = 7,
	--left = 25,
	--top = 195,
	x = display.contentWidth * 0.41 - 55,
	y = display.contentHeight * 0.5 - 55,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn8 = widget.newButton( {
	label = 8,
	id = 8,
	--left = 80,
	--top = 195,
	x = display.contentWidth * 0.41,
	y = display.contentHeight * 0.5 - 55,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )

local btn9 = widget.newButton( {
	label = 9,
	id = 9,
	--left = 135,
	--top = 195,
	x = display.contentWidth * 0.41 + 55,
	y = display.contentHeight * 0.5 - 55,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = numBtnTapped
	} )
--btn9:addEventListener("tap",numBtnTapped)

local btnSomar = widget.newButton({
	label = "+",
	id = "+",
	--left = 190,
	--top = 305,
	x = display.contentWidth * 0.41 + 110,
	y = display.contentHeight * 0.5 + 55,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnDiminuir = widget.newButton({
	label = "-",
	id = "-",
	--left = 190,
	--top = 250,
	x = display.contentWidth * 0.41 + 110,
	y = display.contentHeight * 0.5,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnVezes = widget.newButton({
	label = "*",
	id = "x",
	--left = 190,
	--top = 195,
	x = display.contentWidth * 0.41 + 110,
	y = display.contentHeight * 0.5 - 55,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnDividir = widget.newButton({
	label = "/",
	id = "/",
	--left = 190,
	--top = 140,
	x = display.contentWidth * 0.41 + 110,
	y = display.contentHeight * 0.5 - 110,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnPonto = widget.newButton({
	label = ".",
	id = ".",
	--left = 80,
	--top = 360,
	x = display.contentWidth * 0.41,
	y = display.contentHeight * 0.5 + 110,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = decimalBtnTapped
	} )

local btnPorcentagem = widget.newButton({
	label = "%",
	id = "%",
	--left = 135,
	--top = 140,
	x = display.contentWidth * 0.41 + 55,
	y = display.contentHeight * 0.5 - 110,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnRaiz = widget.newButton({
	label = "V¯",
	id = "v",
	--left = 80,
	--top = 140,	
	x = display.contentWidth * 0.41,
	y = display.contentHeight * 0.5 - 110 ,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnDel = widget.newButton({
	label = "C",
	id = "c",
	--left = 25,
	--top = 140,
	x = display.contentWidth * 0.41 - 55,
	y = display.contentHeight * 0.5 - 110,
	fontSize = 30,
	width = 50, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	} )

local btnIgual = widget.newButton({
	label = "=",
	id = "=",
	--left = 136,
	--top = 360,
	x = display.contentWidth * 0.41 + 82,
	y = display.contentHeight * 0.5 + 110,
	fontSize = 30,
	width = 105, height = 50,
	labelColor = {default={1,0,0}, over={1,1,1, 0.9}},
	shape = "roundedrect", 
	fillColor = {default = {55, 255, 99}, over = {233/255, 30/255, 99/255, .8}},
    strokeColor = {default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8, 1}},
    strokeWidth = 1,
    onEvent = mathBtnTapped
	})





