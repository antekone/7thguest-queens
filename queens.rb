$queens = 0

def clearMatrix
	$matrix = [
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ],
		[ 0,0,0,0,0,0,0,0 ]
	]
end

def printMatrix
	$matrix.each do |row|
		row.each do |i|
			print("#{i} ")
		end

		puts
	end

	puts
end

def collision(dx, dy)
	8.times do |d|
		return true if($matrix[dy][d] == 1 and d != dx)
		return true if($matrix[d][dx] == 1 and d != dy)

		if(dx - d >= 0 and dy - d >= 0)
			return true if($matrix[dy - d][dx - d] == 1)
		end

		if(dx + d < 8 and dy + d < 8)
			return true if($matrix[dy + d][dx + d] == 1)
		end

		if(dy - d >= 0 and dx + d < 8)
			return true if($matrix[dy - d][dx + d] == 1)
		end

		if(dy + d < 8 and dx - d >= 0)
			return true if($matrix[dy + d][dx - d] == 1)
		end
	end

	false
end

def putQueen(candidateX, candidateY)
	if(not collision(candidateX, candidateY))
		$matrix[candidateY][candidateX] = 1
		return true
	end

	false
end

$tries = 0
$solutions = 0
def placeQueen(nest)
	return true if(nest == 8)

	8.times do |y|
		8.times do |x|
			return false if(x == 7 and y == 7)

			if(not collision(x, y))
				$matrix[y][x] = 1
				$tries += 1

				ret = placeQueen(nest + 1)
				if(ret == true and nest == 0)
					$solutions += 1
					puts("Solution #{$solutions}:")
					printMatrix
					clearMatrix
				elsif(ret == true and nest > 0)
					return true
				end

				$matrix[y][x] = 0
			end
		end
	end

	false
end

clearMatrix
puts("Calculating...")

if(placeQueen(0))
	puts("Done after #{$tries} tries")
	printMatrix
else
	puts("NOT possible.")
end

