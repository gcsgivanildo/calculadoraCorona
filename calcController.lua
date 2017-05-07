local class = {}

local operand1, operand2 = 0, 0
local operador = "+"

--este sinalizador será 'verdadeiro' se o usuário tentar dividir por 0
class.foundError = false
-- funcçoes setter
function class.setOp1(value)
	operand1 = value
end

function class.setOp2( value )
	operand2 = value
end

function class.setOperador( str )
	--função para definir o operador
	if str ~= "=" then
		operador = str 
	end
end

--funções Getter
function class.getOp1( )
	return operand1
end

function class.getOp2(  )
	return operand2
end

function class.getOperador( )
	return operador
end

--funções matemáticas
function class.add(  )
	class.setOp1(operand1 + operand2)
end

function class.sub(  )
	class.setOp1(operand1 - operand2)
end

function class.mul(  )
	class.setOp1(operand1 * operand2)
end

function class.div(  )
	local result
	if tonumber( operand2 ) ~= 0 then
		result = operand1 / operand2
	else
		result = 0
		class.foundError = true	
	end
	class.setOp1(result)
end

function class.por( )
	class.setOp1(operand1 * operand2/100)
end

function class.raiz()
	--class.setOp1(operand1^0.5)
	class.setOp1(math.sqrt(operand1))
end

function class.clear()
	class.setOp1(0)
	class.setOp2(0)
	class.setOperador("+")
	class.foundError = false
end

 function class.performOperation(  )	
 	local mathOp = class.getOperador()

 	if mathOp == "-" then
 		class.sub()
 	elseif mathOp == "+" then
 		class.add()
 	elseif mathOp == "x" then
 		class.mul()
 	elseif mathOp == "/" then
 		class.div()
 	elseif mathOp == "%" then
 		class.por()
 	elseif mathOp == "v" then
 		class.raiz()
 	end
 end
return class