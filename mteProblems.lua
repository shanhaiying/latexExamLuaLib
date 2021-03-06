-- -*-two-mode-*-

frc = require('fraction')
vec = require('vector')
st = require('sets')
-- mcp = require('mcProblem')
-- mcp.chcFun = [[\chcSix]]
mp = require('mathProblem')
mp.chcFun = [[\chcSix]]
mp.numberChoices = 6

ef = require('enumForm')
answers = ef.new()

--ansBlanks = createBlankList( 25 )

-- needed only with mcProblem
function mkchc( lst ) 
   return randPerm( distinctElems( 6, lst ) )
end

-- function mklatex( tmpl, sub )
--    return string.format( tmpl, table.unpack( sub ) )
-- end

-- function easyTwoSets()
--    local AB, Ab, aB, ab = distinctRands( 4, 1, 9 )
--    local A, B, AuB, U = AB + Ab, AB + aB, Ab + AB + aB, AB + Ab + aB + ab
--    local anslst = { AB, Ab, aB, ab }
--    local dict = { [[A\cap B]], [[A\cap B']], [[A'\cap B]], [[A'\cap B']] }
--    local latextmpl = [[ Suppose that \(A\) and \(B\) are two sets such
--    that \(\crd{A}=%d\), \(\crd{B}=%d\), and \(\crd{A\cup B}=%d\). 
--    If \(\crd{U}=%d\), then what is \(\crd{%s}\)? \\
--    \\
--    \chcSix{%d}{%d}{%d}{%d}{%d}{%d}]]
--    local q = math.random( 4 )
--    local ans = table.remove( anslst, q )
--    local chclst = {}
--    listConcat( chclst, { ans, A + B, 0 }, anslst )
--    local sublst = {}
--    listConcat( sublst, { A, B, AuB, U, dict[q] }, randPerm( chclst ) )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex
-- end 

easyTwoSets = mp:new(
   { [[ Suppose that \(A\) and \(B\) are two sets such
     that \(\crd{A}=@A \), \(\crd{B}=@B \), and \(\crd{A\cup B}=@AuB \). 
     If \(\crd{U}=@U \), then what is \(\crd{ @Q }\)? ]],
     
     [[ Suppose that set \(A\) has size @A, set \(B\) has size @B, and
     their union has size @AuB.  What is the size of \( @Q \)? ]] },
   function( self )
      local AB, Ab, aB, ab = distinctRands( 4, 1, 9 )
      local A, B, AuB, U = AB + Ab, AB + aB, Ab + AB + aB, AB + Ab + aB + ab
      local anslst = { AB, Ab, aB, ab }
      local dict = { [[A\cap B]], [[A\cap B']], [[A'\cap B]], [[A'\cap B']] }
      local q = math.random( 4 )
      return { A = A, B=B, AuB=AuB, U=U, Q=dict[q] },
             listJoin( { anslst[ q ] }, anslst, 
		       { A, B, A + B, 0 } )
   end
)




-- function easyCondProb()
--    local XY, Xy, xY, xy = distinctRands( 4, 1, 9 )
--    local total = XY + Xy + xY + xy
--    AB, Ab, aB, ab = frc.new(XY,total), frc.new(Xy,total), frc.new(xY,total), frc.new(xy,total)
--    local A, B, AuB, U = AB + Ab, AB + aB, Ab + AB + aB, AB + Ab + aB + ab
--    local dict = { [[\cpr{E}{F}]], [[\cpr{F}{E}]], [[\cpr{E}{F'}]], [[\cpr{F}{E'}]] }
--    local anslst = { frc.new(XY,XY+xY), frc.new(XY,XY+Xy), 
-- 		    frc.new(Xy,Xy+xy), frc.new(xY,xY+xy) }
--    local latextmpl = [[ Suppose that \(E\) and \(F\) are two events such
--    that \(\pr{E}=%s\), \(\pr{F}=%s\), and \(\pr{E\cap F}=%s\). 
--    What is \(%s\)? \\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local q = math.random( 3, 4 )
--    local ans = table.remove( anslst, q )
--    local chclst = {}
--    listConcat( chclst, { ans, 0, 1 }, anslst )
--    local sublst = {}
--    listConcat( sublst, { A, B, AB, dict[q] }, randPerm( chclst ) )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    latex = string.gsub( latex, '0.00', '0' )
--    latex = string.gsub( latex, '1.00', '1' )
--    return latex
-- end 

easyCondProb = mp:new(
   [[ Suppose that \(E\) and \(F\) are two events such
   that \(\pr{E}=%s\), \(\pr{F}=%s\), and \(\pr{E\cap F}=%s\). 
   What is \(%s\)?]],
   function()
      local XY, Xy, xY, xy = distinctRands( 4, 1, 9 )
      local total = XY + Xy + xY + xy
      AB, Ab, aB, ab = frc.new(XY,total), frc.new(Xy,total), frc.new(xY,total), frc.new(xy,total)
      local A, B, AuB, U = AB + Ab, AB + aB, Ab + AB + aB, AB + Ab + aB + ab
      local dict = { [[\cpr{E}{F}]], [[\cpr{F}{E}]], [[\cpr{E}{F'}]], [[\cpr{F}{E'}]] }
      local anslst = { frc.new(XY,XY+xY), frc.new(XY,XY+Xy), 
		       frc.new(Xy,Xy+xy), frc.new(xY,xY+xy) }
      local q = math.random( 3, 4 )
      local ans = table.remove( anslst, q )
      return { A, B, AB, dict[q] }, 
             listJoin( { ans }, anslst, { 0, 1 },
		       { frc.new(XY,total), frc.new(xy,total), 
			 frc.new(Xy,total), frc.new(xY,total) })
   end
)

-- function easyTwoIndepEvs()
--    local A = math.random( 4 )
--    local B = math.random( 6, 9 ); while B == 1 - A do B = math.random( 6, 9 ) end
--    A, B = A/10, B/10
--    local AB, ab = A * B, ( 1 - A ) * ( 1 - B )
--    local Ab, aB = A * ( 1 - B ), ( 1 - A ) * B
--    local AuB, U = Ab + AB + aB, AB + Ab + aB + ab
--    local anslst = { AB, Ab, aB, ab }
--    local dict = { [[E\cap F]], [[E\cap F']], [[E'\cap F]], [[E'\cap F']] }
--    local latextmpl = [[ Suppose that \(E\) and \(F\) are two
--    independent events such
--    that \(\pr{E}=%.1f\) and \(\pr{F}=%.1f\).
--    What is \(\pr{%s}\)? \\
--    \\
--    \chcSix{%.2f}{%.2f}{%.2f}{%.2f}{%.2f}{%.2f}]]
--    local q = math.random( 4 )
--    local ans = table.remove( anslst, q )
--    local chclst = {}
--    listConcat( chclst, { ans, 1, 0 }, anslst )
--    local sublst = {}
--    listConcat( sublst, { A, B, dict[q] }, randPerm( chclst ) )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    latex = string.gsub( latex, '0.00', '0' )
--    latex = string.gsub( latex, '1.00', '1' )
--    return latex
-- end 

easyTwoIndepEvs = mp:new(
   { [[ Suppose that \(E\) and \(F\) are two
     independent events such
     that \(\pr{E}=@A\) and \(\pr{F}=@B\).
     What is \(\pr{@Q}\)? ]],

     [[ Suppose the probability of snow tomorrow is @A while the
     probability of IU winning tomorrow's basketball game is @B.
     Assuming these events are independent, what is the probability
     that @Q? ]] },
   function( self )
      --local s = self
      A = math.random( 4 )
      B = math.random( 6, 9 ); while B == 1 - A do B = math.random( 6, 9 ) end
      A, B = A/10, B/10
      local AB, ab = A * B, ( 1 - A ) * ( 1 - B )
      local Ab, aB = A * ( 1 - B ), ( 1 - A ) * B
      local AuB, U = Ab + AB + aB, AB + Ab + aB + ab
      local anslst = { AB, Ab, aB, ab }
      -- local dict = ({ { [[E\cap F]], [[E\cap F']], 
      -- 			[[E'\cap F]], [[E'\cap F']] },
      -- 		      { 'it snows and IU wins',
      -- 			'it snows and IU loses',
      -- 			'it does not snow and IU wins',
      -- 			'it does not not snow and IU loses' } })
      local dict = { { [[E\cap F]], 'it snows and IU wins' },
		     { [[E\cap F']], 'it snows and IU loses' },
		     { [[E'\cap F]], 'it does not snow and IU wins' },
		     { [[E'\cap F']], 'it does not not snow and IU loses' }
      }
      local q = math.random( 2, 3 )
      local ans = table.remove( anslst, q )
      --s.A, s.B, s.Q = A, B, dict[q]
      Q = dict[q]
      return listJoin( { ans }, anslst, 
		       { A, B, 1, 0,
			 1-AB, 1-Ab, 1-aB, 1-ab } )
   end
)
--easyTwoIndepEvs.subFun = 'self'

-- function storyTwoIndep()
--    local latextmpl = [[Suppose there is a 
--    %d\percent 
--    chance of snow tomorrow, and  a 
--    %d\percent 
--    chance that IU wins tomorrow's basketball game.
--    Assuming that those two events are independent,
--    what is the probability that tomorrow there is %s 
--    snow and IU %s? \\
--    \\
--    \chcSix{%d\percent}{%d\percent}{%d\percent}{%d\percent}{%d\percent}{%d\percent}]]
--    local snow, win = distinctRands( 2, 1, 4 )
--    local snowqlst = { '', 'no' }
--    local gameqlst = { 'wins', 'loses' }
--    local qs = math.random( 2 )
--    local qg = 3 - qs
--    local anslst = { snow * win,
-- 		    snow * ( 10 - win ),
-- 		    ( 10 - snow ) * win,
-- 		    ( 10 - snow ) * ( 10 - win ) }
--    local wrong = { snow + win,
-- 		    snow + ( 10 - win ),
-- 		    ( 10 - snow ) + win,
-- 		    ( 10 - snow ) + ( 10 - win ) }
--    local q = 2 * qs + qg - 2
--    local anslst = listJoin( { anslst[q] }, anslst, wrong )
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { snow * 10, win * 10, 
-- 			      snowqlst[qs], gameqlst[qg] },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex
-- end 

storyTwoIndep = mp:new(
   [[Suppose there is a 
   %d\percent 
   chance of snow tomorrow, and  a 
   %d\percent 
   chance that IU wins tomorrow's basketball game.
   Assuming that those two events are independent,
   what is the probability that tomorrow there is %s 
   snow and IU %s? ]],
   function()
      local snow, win = distinctRands( 2, 1, 4 )
      local snowqlst = { '', 'no' }
      local gameqlst = { 'wins', 'loses' }
      local qs = math.random( 2 )
      local qg = 3 - qs
      local anslst = { snow * win,
		       snow * ( 10 - win ),
		       ( 10 - snow ) * win,
		       ( 10 - snow ) * ( 10 - win ) }
      local wrong = { snow + win,
		      snow + ( 10 - win ),
		      ( 10 - snow ) + win,
		      ( 10 - snow ) + ( 10 - win ) }
      local q = 2 * qs + qg - 2
      return { snow * 10, win * 10, snowqlst[qs], gameqlst[qg] }, 
             listJoin( { anslst[q] }, anslst, wrong )
   end 
)


-- function tree22()
--    local latextmpl = [[ Every morning a math instructor picks out two socks
--    completely at random from his closet; there's only a %d\percent
--    chance they match.  If they don't match there is a %d\percent
--    chance his students will laugh at him, while if his socks do match
--    there is only a %d\percent
--    chance of his students laughing at him.

--    On a given day, what is the probability that his students laugh at him?
--    \\ \\
--    \chcSix{%.2f}{%.2f}{%.2f}{%.2f}{%.2f}{%.2f} ]]

--    local match = math.random( 1, 4 ) * 10
--    local laughdont = math.random( 6, 10 ) * 10
--    local laughmatch = math.random( 1, 5 ) * 10
--    local anslst = { ( match/100 * laughmatch + ( 1 - match/100 ) * laughdont ) / 100,
-- 		    (match * laughmatch)/10000,
-- 		    ( 1 - match/100 ) * laughdont/100,
-- 		    (laughmatch + laughdont) / 100,
-- 		    1 - match/100,
-- 		    laughmatch/100 }
--    local sublst = {}
--    listConcat( sublst, { match, laughdont, laughmatch }, randPerm( anslst ) )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    latex = string.gsub( latex, '0.00', '0' )
--    latex = string.gsub( latex, '1.00', '1' )
--    return latex
-- end 

tree22 = mp:new(
   { [[ Every morning a math instructor picks out two socks
     completely at random from his closet; there's only a @match\percent
     chance they match.  If they don't match there is a
     @laughdont\percent 
     chance his students will laugh at him, while if his socks do match
     there is only a @laughmatch\percent
     chance of his students laughing at him.
     
     On a given day, what is the probability that his students laugh
     at him?  ]],

     [[ If you get an A in Finite there is a @laughdont\percent chance
     that you will get into medical school, but if you get less than
     an A in Finite then your chance of getting into medical school is
     only @laughmatch\percent.  Suppose the probability that you get
     an A in Finite is @A\percent.  What's the probability that
     you get into medical school? ]] },
   
   function()
      match = math.random( 1, 4 ) * 10
      laughdont = math.random( 6, 10 ) * 10
      laughmatch = math.random( 1, 5 ) * 10
      local anslst = { ( match/100 * laughmatch + ( 1 - match/100 ) * laughdont ) / 100,
		       (match * laughmatch)/10000,
		       ( 1 - match/100 ) * laughdont/100,
		       (laughmatch + laughdont) / 100,
		       1 - match/100,
		       laughmatch/100,
		       ( match/100 * laughmatch + laughdont )}
      return { match=match, laughdont=laughdont,
	       laughmatch=laughmatch, A = 100 - match },
             anslst
   end
)


-- function partitionProb( a, ab, bc )
--    -- local a, ab, bc
--    a = a or math.random( 1, 9 )
--    ab = ab or math.random( 2, 5)
--    bc = bc or math.random( 2, 5)
--    local total = ( 1 + ab + ab * bc ) * a

--    res = string.format(
-- [[
-- A universal set $U$ with %d elements has been partitioned into three
-- subsets, $A$, $B$, and $C$.  If $B$ is %d times the size of $A$ and
-- $C$ is %d times the size of $B$, then how many elements are in
-- $B$? \\

-- \chcSix{%d}{%d}{%d}{%d}{%d}{%d}
-- ]],
-- total, ab, bc,
-- table.unpack( randPerm{
-- 		 a * ab,
-- 		 a,
-- 		 ab,
-- 		 total,
-- 		 a + a * ab,
-- 		 a + 1 })
-- )

--    return res
-- end

partitionProb = mp:new(
   [[
   A universal set $U$ with %d elements has been partitioned into three
   subsets, $A$, $B$, and $C$.  If $B$ is %d times the size of $A$ and
   $C$ is %d times the size of $B$, then how many elements are in
   $B$? ]],
   function( self, a, ab, bc )
      a = a or math.random( 1, 9 )
      ab = ab or math.random( 2, 5)
      bc = bc or math.random( 2, 5)
      local total = ( 1 + ab + ab * bc ) * a
      return { total, ab, bc }, 
             { a * ab, a, ab, total, a + a * ab, a + 1,
	       a * ab * bc, a * bc, ab * bc,
	       bc, (a-1) * ab }
   end
)

-- function productCode()
--    local setC
--    setC = { 'B', 'D', 'G', 'K', 'M', 'P', 'T', 'R', 'S', 'Z' }
   
--    -- setC = { 'B', 'D', 'F', 'G', 'K', 'M', 'P', 'S', 'T', 'Z' }
--    local lenC = math.random( 3, #setC )
--    -- local lenC = math.random( 3, #setC )
--    local chC = table.concat( setC, ',' ):sub( -(2 * lenC - 1) )
--    -- local chC = table.concat( setC, ',' ):sub( 2 * lenC - 1 )

--    res = string.format(
-- [[
-- Apple constructs the names for its digital voices
-- from the consonants 
-- \[C=\stt{%s}\]
-- and the vowels 
-- \[V=\stt{A,E,I,O,U}\]
--  in the following way.  First a consonant is chosen
--  from \(C\), then a vowel is
-- chosen from $V$, then a {\em different} consonant is chosen from $C$,
-- and then a vowel (possibly the same) from $V$.
-- For example, ``Siri'' and ``Zasu'' are both possible names, but
-- ``Rori'' is {\em not} possible.

-- How many possible digital voice names are there? \\

-- \chcSix{%d}{%d}{%d}{%d}{%d}{%d}
-- ]],
-- chC, 
-- table.unpack( randPerm{
-- 		 lenC * 5 * (lenC - 1) * 5,
-- 		 lenC * 5 * (lenC - 1) * 4,
-- 		 lenC * 5 * lenC * 5,
-- 		 lenC * 5 * lenC * 4,
-- 		 lenC * (lenC - 1),
-- 		 lenC * lenC     })
--    )
--    return res
-- end

productCode = mp:new(
   [[ Apple constructs the names for its digital voices
   from the consonants 
   \[C=\stt{%s}\]
     and the vowels 
     \[V=\stt{A,E,I,O,U}\]
     in the following way.  First a consonant is chosen
     from \(C\), then a vowel is
     chosen from $V$, then a {\em different} consonant is chosen from $C$,
     and then a vowel (possibly the same) from $V$.
     For example, ``Siri'' and ``Zasu'' are both possible names, but
     ``Rori'' is {\em not} possible.

     How many possible digital voice names are there? ]],
   function()
      local setC
      setC = { 'B', 'D', 'G', 'K', 'M', 'P', 'T', 'R', 'S', 'Z' }
      
      -- setC = { 'B', 'D', 'F', 'G', 'K', 'M', 'P', 'S', 'T', 'Z' }
      local lenC = math.random( 3, #setC )
      -- local lenC = math.random( 3, #setC )
      local chC = table.concat( setC, ',' ):sub( -(2 * lenC - 1) )
      -- local chC = table.concat( setC, ',' ):sub( 2 * lenC - 1 )
      return { chC }, 
             { lenC * 5 * (lenC - 1) * 5,
	       lenC * 5 * (lenC - 1) * 4,
	       lenC * 5 * lenC * 5,
	       lenC * 5 * lenC * 4,
	       lenC * (lenC - 1),
	       lenC * lenC,
	       5 * 5, 5 * 4, lenC * 5, lenC * 5 * lenC,
	       lenC * 5 * 5}
   end
)



-- function colors( q )
--    local latextmpl = [[A jar contains %d 
--    red and %d 
--    green jelly beans.
--    Two jelly beans are taken simultaneously and completely at random
--    from the jar.  
--    What is the probability that
--    %s \\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local red, green = distinctRands( 2, 2, 5 )
--    local total = red + green
--    local ns, ng, nr = comb( total, 2 ), comb( green, 2 ), comb( red, 2 )
--    local same, diff = ng + nr, red * green
--    local qlst = { [[both are the same color?]],
-- 		  [[each is a different color?]],
-- 		  [[both are red?]],
-- 		  [[both are green?]]}
--    local anslst = { frc.new( same, ns ),
-- 		    frc.new( diff, ns ),
-- 		    frc.new( nr, ns ),
-- 		    frc.new( ng, ns ) }
--    local wrong = { frc.new( red^2, ns ),
-- 		   frc.new( green^2, ns ),
-- 		   frc.new( green, total ),
-- 		   frc.new( red, total ),
-- 		   frc.new( 1, total ),
-- 		   frc.new( 1, ns )}
--    local q = q or math.random(4)
--    local ans = table.remove( anslst, q )
--    local chclst = listJoin( { ans }, anslst, wrong )
--    chclst = distinctElems( 6, chclst )
--    chclst = randPerm( chclst )
--    local sublst = listJoin( { red, green, qlst[q] }, chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex
-- end 

colors = mp:new(
   [[A jar contains %d 
   red and %d 
   green jelly beans.
   Two jelly beans are taken simultaneously and completely at random
   from the jar.  
   What is the probability that
   %s ]],
   function ( self, q )
      local red, green = distinctRands( 2, 2, 5 )
      local total = red + green
      local ns, ng, nr = comb( total, 2 ), comb( green, 2 ), comb( red, 2 )
      local same, diff = ng + nr, red * green
      local qlst = { [[both are the same color?]],
		     [[each is a different color?]],
		     [[both are red?]],
		     [[both are green?]]}
      local anslst = { frc.new( same, ns ),
		       frc.new( diff, ns ),
		       frc.new( nr, ns ),
		       frc.new( ng, ns ) }
      local wrong = { frc.new( red^2, ns ),
		      frc.new( green^2, ns ),
		      frc.new( green, total ),
		      frc.new( red, total ),
		      frc.new( 1, total ),
		      frc.new( 1, ns )}
      local q = q or math.random(4)
      local ans = table.remove( anslst, q )
      return { red, green, qlst[ q ] },
             listJoin( { ans }, anslst, wrong )
   end
)

-- function horserace( name )
--    local latextmpl = [[ %s 
--    horses are running in a race; one the horses is named %s.
--    At the end of the race the complete order in which the %d 
--    horses finished is recorded.  In how many outcomes does %s 
--    finish among the top %d horses? \\
--    \\
--    \chcSix{%d}{%d}{%d}{%d}{%d}{%d}]]
--    local cards = { 'Three', 'Four', 'Five', 'Six', 'Seven' }
--    local num = math.random( 4, 6 )
--    local crdstr = cards[ num - 2 ]
--    local top = math.random( 2, num - 1 )
--    local anslst = { top * perm( num - 1, num - 1 ),
-- 		    top * perm( num, num ),
-- 		    perm( num - 1, num - 1 ),
-- 		    perm( top, top ),
-- 		    top * num,
-- 		    top * (num - 1),
-- 		    top + num,
-- 		    top + num -1 }
--    anslst = distinctElems( 6, anslst )
--    local sublst = listJoin( { crdstr, name, num, name, top },
-- 			    randPerm( anslst ) )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex
-- end 

horserace = mp:new(
   [[ %s horses are running in a race; one the horses is named %s.
   At the end of the race the complete order in which the %d 
   horses finished is recorded.  In how many outcomes does %s 
   finish among the top %d horses? ]],
   function( self, name )
      local cards = { 'Three', 'Four', 'Five', 'Six', 'Seven' }
      local num = math.random( 4, 6 )
      local crdstr = cards[ num - 2 ]
      local top = math.random( 2, num - 1 )
      local anslst = { top * perm( num - 1, num - 1 ),
		       top * perm( num, num ),
		       perm( num - 1, num - 1 ),
		       perm( top, top ),
		       top * num,
		       top * (num - 1),
		       top + num,
		       top + num -1 }
      return { crdstr, name, num, name, top }, anslst
   end
)






-- function weights( )
--    local latextmpl = [[There are %d 
--    candidates for one party's presidential nomination, including 
--    %d women and %d men.
--    Suppose that all the men are equally likely to win the nomination,
--    and all the women are are equally likely to win the nomination,
--    but that each %s is %d 
--    times as likely as each %s to win the nomination.
--    What is the probability that a %s wins the nomination? \\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local qlst = { 'woman', 'man' }
--    local nmen, nwom = distinctRands( 2, 3, 6 )
--    local nums = { nwom, nmen }
--    local fact = math.random( 2, 5 )
--    local fcts = { }
--    local fave = math.random( 2 )
--    local under = 3 - fave
--    fcts[ fave ], fcts[ under ] = fact, 1
--    local nund, nfav  = nums[ under ], nums[ fave ]
--    local total = nund + nfav * fact
--    local anslst = { frc.new( nwom * fcts[1], total ),
-- 		    frc.new( nmen * fcts[2], total ) }
--    local wrong = { frc.new( nund, nund + nfav ),
-- 		   frc.new( nfav, nund + nfav ),
-- 		   frc.new( 1, fact + 1 ),
-- 		   frc.new( fact, fact + 1 ),
-- 		   frc.new( 1, 2 ),
-- 		   frc.new( 1, nmen ),
-- 		   frc.new( 1, nwom ),
-- 		   frc.new( math.min( nmen, nwom ), math.max( nmen, nwom ) ),
-- 		   frc.new( 1, total ),
-- 		   frc.new( 1, nfav * fact ),
-- 		   frc.new( 1, nund )}
--    local q = math.random( 2 )
--    local chclst = listJoin( { anslst[q] }, anslst, wrong )
--    chclst = distinctElems( 6, chclst )
--    local sublst = listJoin( { nmen + nwom, nwom, nmen, 
-- 			      qlst[fave], fact, qlst[under], qlst[q] },
-- 			    randPerm( chclst ) )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex
-- end 

weights = mp:new(
   [[There are %d 
   candidates for one party's presidential nomination, including 
   %d women and %d men.
   Suppose that all the men are equally likely to win the nomination,
   and all the women are are equally likely to win the nomination,
   but that each %s is %d 
   times as likely as each %s to win the nomination.
   What is the probability that a %s wins the nomination? ]],
   function( self )
      local qlst = { 'woman', 'man' }
      local nmen, nwom = distinctRands( 2, 3, 6 )
      local nums = { nwom, nmen }
      local fact = math.random( 2, 5 )
      local fcts = { }
      local fave = math.random( 2 )
      local under = 3 - fave
      fcts[ fave ], fcts[ under ] = fact, 1
      local nund, nfav  = nums[ under ], nums[ fave ]
      local total = nund + nfav * fact
      local anslst = { frc.new( nwom * fcts[1], total ),
		       frc.new( nmen * fcts[2], total ) }
      local wrong = { frc.new( nund, nund + nfav ),
		      frc.new( nfav, nund + nfav ),
		      frc.new( 1, fact + 1 ),
		      frc.new( fact, fact + 1 ),
		      frc.new( 1, 2 ),
		      frc.new( 1, nmen ),
		      frc.new( 1, nwom ),
		      frc.new( math.min( nmen, nwom ), math.max( nmen, nwom ) ),
		      frc.new( 1, total ),
		      frc.new( 1, nfav * fact ),
		      frc.new( 1, nund )}
      local q = math.random( 2 )
      return { nmen + nwom, nwom, nmen, 
	       qlst[ fave ], fact, qlst[under], qlst[q] },
             listJoin( { anslst[q] }, anslst, wrong )
   end
)




-- function threeCircle()
--    local pieces = { 'abc', 'Abc', 'aBc', 'abC', 'ABc', 'AbC', 'aBC', 'ABC' }
--    local sizes = {}
--    local total = 0
--    for _, p in ipairs( pieces ) do
--       sizes[ p ] = math.random( 1, 9 )
--       total = total + sizes[ p ]
--    end
--    local pronounlst = { 'she', 'he' }
--    local pronoun = pronounlst[ math.random( 2 ) ]
--    local qlst = { 'nothing wrong with them',
-- 		  'only dead batteries',
-- 		  'only cracked displays',
-- 		  'only missing buttons' }
--    local anslst = { sizes.abc, sizes.Abc, sizes.aBc, sizes.abC }
--    local wrong = table.pack( distinctRands( 9, 1, 9 ) )
--    local q = math.random( 4 )
--    local chclst = listJoin( { anslst[q] }, anslst, wrong )
--    chclst = randPerm( distinctElems( 6, chclst ) )
--    local latextmpl = [[
-- A math instructor has %d 
-- calculators in his office.
-- Of them, %d 
-- have dead batteries, %d 
-- have cracked displays,
-- and %d 
-- have missing buttons.
-- Of those with dead batteries,
-- %d 
-- also have cracked displays 
-- and %d 
-- also have missing buttons.
-- Of those with cracked displays, %d
-- also have missing buttons.
-- There are %d 
-- with dead batteries, cracked displays, and missing buttons,
-- which %s's thinking about throwing out.

-- How many calculators does %s 
-- have with %s? \\
-- \\
-- \chcSix{%d}{%d}{%d}{%d}{%d}{%d}
-- ]]

--    local sublst = listJoin( { total, 
-- 			       sizes.Abc + sizes.ABc + sizes.AbC + sizes.ABC,
-- 			       sizes.aBc + sizes.aBC + sizes.ABC + sizes.ABc,
-- 			       sizes.abC + sizes.aBC + sizes.AbC + sizes.ABC,
-- 			       sizes.ABc + sizes.ABC,
-- 			       sizes.ABC + sizes.AbC,
-- 			       sizes.ABC + sizes.aBC,
-- 			       sizes.ABC,
-- 			       pronoun, pronoun, 
-- 			       qlst[q] },
-- 			     chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex
-- end

threeCircle = mp:new(
   [[ A math instructor has %d 
   calculators in his office.
   Of them, %d 
   have dead batteries, %d 
   have cracked displays,
   and %d 
   have missing buttons.
   Of those with dead batteries,
   % d 
   also have cracked displays 
   and %d 
   also have missing buttons.
   Of those with cracked displays, %d
   also have missing buttons.
   There are %d 
   with dead batteries, cracked displays, and missing buttons,
   which %s's thinking about throwing out.

   How many calculators does %s 
   have with %s?]],
   function( self )
      local pieces = { 'abc', 'Abc', 'aBc', 'abC', 'ABc', 'AbC', 'aBC', 'ABC' }
      local sizes = {}
      local total = 0
      for _, p in ipairs( pieces ) do
	 sizes[ p ] = math.random( 1, 9 )
	 total = total + sizes[ p ]
      end
      local pronounlst = { 'she', 'he' }
      local pronoun = pronounlst[ math.random( 2 ) ]
      local qlst = { 'nothing wrong with them',
		     'only dead batteries',
		     'only cracked displays',
		     'only missing buttons' }
      local anslst = { sizes.abc, sizes.Abc, sizes.aBc, sizes.abC }
      local wrong = table.pack( distinctRands( 9, 1, 9 ) )
      local q = math.random( 4 )
      return { total, 
	       sizes.Abc + sizes.ABc + sizes.AbC + sizes.ABC,
	       sizes.aBc + sizes.aBC + sizes.ABC + sizes.ABc,
	       sizes.abC + sizes.aBC + sizes.AbC + sizes.ABC,
	       sizes.ABc + sizes.ABC,
	       sizes.ABC + sizes.AbC,
	       sizes.ABC + sizes.aBC,
	       sizes.ABC,
	       pronoun, pronoun, 
	       qlst[q] },
             listJoin( { anslst[q] }, anslst, wrong )
   end
)


-- function menu()
--    local latextmpl = [[You are ordering a new laptop.  
--    The company you are ordering from gives you the choice of %d
--    different CPUs, of which you must choose one.  You also have the
--    choice of %d
--    different colors, of which you must choose one,
--    and %d
--    different extras (e.g.\ more RAM, video card, mouse, etc.) 
--    of which you can choose %d.
--    How many ways are there for you to order the new laptop?\\
--    \\
--    \chcSix{%d}{%d}{%d}{%d}{%d}{%d}]]
--    local cpus, colors, extras  = distinctRands( 3, 3, 6 )
--    local numex = math.random( 2, extras - 1 )
--    local anslst = { cpus * colors * comb( extras, numex ),
-- 		    cpus * colors * extras,
-- 		    cpus * colors * numex,
-- 		    cpus * colors * numex * extras,
-- 		    cpus * colors * perm( extras, numex ),
-- 		    math.floor( cpus * colors * numex / extras ) }
--    local chclst = randPerm( anslst )
--    local sublst = listJoin( { cpus, colors, extras, numex },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex  
-- end 

menu = mp:new(
   [[You are ordering a new laptop.  
   The company you are ordering from gives you the choice of %d
   different CPUs, of which you must choose one.  You also have the
   choice of %d
   different colors, of which you must choose one,
   and %d
   different extras (e.g.\ more RAM, video card, mouse, etc.) 
   of which you must choose exactly %d.
   How many ways are there for you to order the new laptop? ]],
   function( self )
      local cpus, colors, extras  = distinctRands( 3, 3, 6 )
      local numex = math.random( 2, extras - 1 )
      local anslst = { cpus * colors * comb( extras, numex ),
		       cpus * colors * extras,
		       cpus * colors * numex,
		       cpus * colors * numex * extras,
		       cpus * colors * perm( extras, numex ),
		       math.floor( cpus * colors * numex / extras ),
		       comb( cpus + colors + extras, numex + 2 ),
		       colors * comb( extras, numex ),
		       cpus * comb( extras, numex ) }
      return { cpus, colors, extras, numex }, anslst
   end
)


-- function twodice()
--    local latextmpl = [[Two fair dice are rolled.
--    What is the probability that the sum of the two dice is either
--    %d or %d? \\
--    \\ 
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local s1, s2 = distinctRands( 2, 2, 12 )
--    local function size( x )
--       return 6 - math.abs( x - 7 )
--    end
--    local anslst = { frc.new( size( s1 ) + size ( s2 ), 36 ),
-- 		    frc.new( 2, 36 ),
-- 		    frc.new( s1 + s2, 36 ),
-- 		    frc.new( size( s1 ), 36 ),
-- 		    frc.new( size( s2 ), 36 ),
-- 		    frc.new( s1, 36 ),
-- 		    frc.new( s2, 36 ),
-- 		    frc.new( 2, 12 ),
-- 		    frc.new( 2, 6 ),
-- 		    frc.new( 1, 6 )}
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { s1, s2 },
-- 			    chclst )
--    return mklatex( latextmpl, sublst ) 
-- end 

twodice = mp:new(
   [[Two fair dice are rolled.
   What is the probability that the sum of the two dice is either
   %d or %d? ]],
   function( self )
      local s1, s2 = distinctRands( 2, 2, 12 )
      local function size( x )
	 return 6 - math.abs( x - 7 )
      end
      return { s1, s2 },
             { frc.new( size( s1 ) + size ( s2 ), 36 ),
	       frc.new( 2, 36 ),
	       frc.new( s1 + s2, 36 ),
	       frc.new( size( s1 ), 36 ),
	       frc.new( size( s2 ), 36 ),
	       frc.new( s1, 36 ),
	       frc.new( s2, 36 ),
	       frc.new( 2, 12 ),
	       frc.new( 2, 6 ),
	       frc.new( 1, 6 ),
	       frc.new( math.random(36), 36 ),
	       frc.new( math.random(36), 36 ),
	       frc.new( math.random(36), 36 ),
	       frc.new( math.random(36), 36 ) }
   end
)

-- function coinCombo()
--    local latextmpl = [[You have %d
--    pennies (1\textcent) and %d
--    nickels (5\textcent) in your pocket.
--    You reach and blindly grab three coins at random.
--    What is the probability that
--    the value of the selected coins is %s? \\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local pens, ncks = distinctRands( 2, 2, 6 )
--    local tot = pens + ncks
--    local ss = comb( tot, 3 )
--    local qlst = { [[at least 5\textcent]],
-- 		  [[less than 5\textcent]],
--                   [[exactly 7\textcent]],
-- 		  [[exactly 11\textcent]] }
--    local anslst = { 1 - frc.new( comb( pens, 3 ), ss ),
-- 		    frc.new( comb( pens, 3 ), ss ),
-- 		    frc.new( comb( pens, 2 ) * ncks, ss ),
-- 		    frc.new( comb( ncks, 2 ) * pens, ss ) }
--    local wrong = { 1 - frc.new( comb( ncks, 3 ), ss ),
-- 		   frc.new( comb( ncks, 3 ), ss ),
-- 		   frc.new( pens, tot ),
-- 		   frc.new( ncks, tot ) }
--    local q = math.random( 4 )
--    local chclst = listJoin( { anslst[q] }, anslst, wrong )
--    chclst = randPerm( distinctElems( 6, chclst ) )
--    local sublst = listJoin( { pens, ncks, qlst[q] },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex  
-- end 

coinCombo = mp:new(
   [[You have %d
   pennies (1\textcent) and %d
   nickels (5\textcent) in your pocket.
   You reach and blindly grab three coins at random.
   What is the probability that
   the value of the selected coins is %s? ]],
   function( self, q )
      local pens, ncks = distinctRands( 2, 2, 6 )
      local tot = pens + ncks
      local ss = comb( tot, 3 )
      local qlst = { [[at least 5\textcent]],
		     [[less than 5\textcent]],
		     [[exactly 7\textcent]],
		     [[exactly 11\textcent]] }
      local anslst = { 1 - frc.new( comb( pens, 3 ), ss ),
		       frc.new( comb( pens, 3 ), ss ),
		       frc.new( comb( pens, 2 ) * ncks, ss ),
		       frc.new( comb( ncks, 2 ) * pens, ss ) }
      local wrong = { 1 - frc.new( comb( ncks, 3 ), ss ),
		      frc.new( comb( ncks, 3 ), ss ),
		      frc.new( pens, tot ),
		      frc.new( ncks, tot ) }
      local q = q or math.random( 4 )
      return { pens, ncks, qlst[q] }, 
             listJoin( { anslst[q] }, anslst, wrong )
   end
)

-- function gumballs()
--    local latextmpl = [[A gumball machine contains %d
--    red gumballs, %d
--    blue gumballs, and %d
--    yellow gumballs.  
--    You put a coin in the machine, 
--    and two gumballs come out, one after the other.
--    What's the probability that the first gumball that comes out is %s
--    and the second gumball is %s?\\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local red, blue, yellow = distinctRands( 3, 2, 6 )
--    local total = red + blue + yellow
--    local ss = perm( total, 2 )
--    local colors = { 'red', 'blue', 'yellow' }
--    local numbers = { red, blue, yellow }
--    local q1, q2 = distinctRands( 2, 1, 3 )
--    local q3 = 6 - q1 - q2
--    local n1, n2, n3 = numbers[ q1 ], numbers[ q2 ],  numbers[ q3 ]
--    local anslst = { frc.new( n1 * n2, ss ),
-- 		    frc.new( n1 * n3, ss ),
-- 		    frc.new( n2 * n3, ss ),
-- 		    frc.new( n1, ss ),
-- 		    frc.new( n2, ss ),
-- 		    frc.new( n3, ss ),
-- 		    frc.new( n1 + n2, total ),
-- 		    frc.new( n3, total )}
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { red, blue, yellow, 
-- 			      colors[q1], colors[q2] },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex  
-- end 

gumballs = mp:new(
   { [[A gumball machine contains @c1
     red gumballs, @c2
     blue gumballs, and @c3
     yellow gumballs.  
     You put a coin in the machine, 
     and two gumballs come out, one after the other.
     What's the probability that the first gumball that comes out is
     @first and the second gumball is @second? ]],

     [[A car rental agency has @c1 Fords, @c2 Toyotas, and @c3
     Metros.  You and a friend go there to rent and each of you is
     given a car chosen at random.  What's the probability that you
     get a @first and your friend gets a @second? ]] },
   function( self )
      local red, blue, yellow = distinctRands( 3, 2, 6 )
      local total = red + blue + yellow
      local ss = perm( total, 2 )
      -- local colors = ({ { 'red', 'blue', 'yellow' },
      -- 			{ 'Ford', 'Toyota', 'Metro' } })
      local colors = { { 'red', 'Ford' },
		       { 'blue', 'Toyota' },
		       { 'yellow', 'Metro' } }
      local numbers = { red, blue, yellow }
      local q1, q2 = distinctRands( 2, 1, 3 )
      local q3 = 6 - q1 - q2
      local n1, n2, n3 = numbers[ q1 ], numbers[ q2 ],  numbers[ q3 ]
      return { c1=red, c2=blue, c3=yellow, 
	       first=colors[q1], second=colors[q2] },
      { frc.new( n1 * n2, ss ),
	frc.new( n1 * n3, ss ),
	frc.new( n2 * n3, ss ),
	frc.new( n1, ss ),
	frc.new( n2, ss ),
	frc.new( n3, ss ),
	frc.new( n1 + n2, total ),
	frc.new( n3, total )}
   end
)


-- function unfairCoin()
--    local latextmpl = [[An unfair coin has probability %s
--    of coming up Heads.
--    This coin is flipped %d times.
--    What is the probability that %s
--    come up at least %d times? \\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local pdnm = math.random( 3, 4 )
--    local ph = frc.new( pdnm - 1, pdnm )
--    local num  = 7 - pdnm
--    local min = math.random( 1, num - 1 )
--    local qlst = { 'Heads', 'Tails' }
--    local q = math.random( 2 )
--    local probs = { ph, 1 - ph }
--    local pq, pqc = probs[ q ], probs[ 3 - q ]
--    local anslst = { bernCum( num, pq, min, num ),
-- 		    bernCum( num, pqc, min, num ),
-- 		    1 - bernCum( num, pq, min, num ),
-- 		    1 - bernCum( num, pqc, min, num ),
-- 		    bernoulli( num, pq, min ),
-- 		    bernoulli( num, pqc, min ),
-- 		    1 - bernoulli( num, pq, min ),
-- 		    1 - bernoulli( num, pqc, min ) }
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { ph, num, qlst[q], min },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    latex, _ = string.gsub( latex, '1 times', '1 time')
--    return latex  
-- end 

unfairCoin = mp:new(
   { [[An unfair coin has probability \(@p\)
     of coming up Heads.
     This coin is flipped @n times.
     What is the probability that @Q
     come up at least @r times? ]],

     [[ A basketball player can make a certain shot on average @num
     out of every @den attempts.  What's the probability that she 
     @Q on at least @r of her next @n attempts? ]] },
   
   function( self )
      local pdnm = math.random( 3, 4 )
      local ph = frc.new( pdnm - 1, pdnm )
      local num  = 7 - pdnm
      local min = math.random( 2, num - 1 )
      local qlst = { { 'Heads', 'succeeds' },
		      { 'Tails', 'fails' } }
      local q = math.random( 2 )
      local probs = { ph, 1 - ph }
      local pq, pqc = probs[ q ], probs[ 3 - q ]
      -- print( '\n Q = ' .. qlst[q] .. '\n' )
      -- print( '\n num = ' .. ph.numer .. '\n' )
      -- print( '\n den = ' .. ph.denom .. '\n' )
      return { p=ph:tolatex(), n=num, Q=qlst[q], r=min,
	       num = ph.numer, den = ph.denom },
             { bernCum( num, pq, min, num ),
	       bernCum( num, pqc, min, num ),
	       1 - bernCum( num, pq, min, num ),
	       1 - bernCum( num, pqc, min, num ),
	       bernoulli( num, pq, min ),
	       bernoulli( num, pqc, min ),
	       1 - bernoulli( num, pq, min ),
	       1 - bernoulli( num, pqc, min ) }
   end
)


-- function breakfast()
--    local latextmpl = [[You have %d
--    boxes of regular cereal and %d
--    boxes of low calorie cereal in your closet.
--    Every morning you grab one box from the %d
--    completely at random for breakfast.
--    What is the probability that in the course of a week (7 days)
--    you have %s 
--    cereal exactly %d times? \\
--    \\
--    \chcLSix{\(%s\)}{\(%s\)}{\(%s\)}{\(%s\)}{\(%s\)}{\(%s\)}]]
--    local qlst = { 'regular', 'low cal' }
--    local qnums = {}
--    qnums[1], qnums[2] = distinctRands( 2, 2, 8 )
--    local total = qnums[1] + qnums[2]
--    local q = math.random( 2 )
--    local qp = frc.new( qnums[ q ], total )
--    local qpc = 1 - qp
--    local anstmpl = [[%d(%s)^%d(%s)^%d]]
--    local nsucc = math.random( 2, 5 )
--    local nfail = 7 - nsucc
--    local function mkan( ... )
--       return string.format( anstmpl, ... )
--    end
--    local anslst = { mkan( comb( 7, nsucc ), qp, nsucc, qpc, nfail ),
-- 		    mkan( comb( 7, nsucc ), qpc, nsucc, qp, nfail ),
-- 		    mkan( nsucc, qp, nsucc, qpc, nfail ),
-- 		    mkan( nfail, qpc, nsucc, qp, nfail ),
-- 		    mkan( nsucc, qpc, nsucc, qp, nfail ),
-- 		    mkan( nfail, qp, nsucc, qpc, nfail ) }
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { qnums[1], qnums[2], total,
-- 			      qlst[ q ], nsucc },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex    
-- end 

breakfast = mp:new(
   [[You have %d
   boxes of regular cereal and %d
   boxes of low calorie cereal in your closet.
   Every morning you grab one box from the %d
   completely at random for breakfast.
   What is the probability that in the course of a week (7 days)
   you have %s 
   cereal exactly %d times? ]],
   function( self )
      local qlst = { 'regular', 'low-cal' }
      local qnums = {}
      qnums[1], qnums[2] = distinctRands( 2, 2, 8 )
      local total = qnums[1] + qnums[2]
      local q = math.random( 2 )
      local qp = frc.new( qnums[ q ], total )
      local qpc = 1 - qp
      local anstmpl = [[\(%d(%s)^%d(%s)^%d\)]]
      local nsucc = math.random( 2, 5 )
      local nfail = 7 - nsucc
      local function mkan( ... )
	 return string.format( anstmpl, ... )
      end
      return { qnums[1], qnums[2], total, qlst[ q ], nsucc },
             { mkan( comb( 7, nsucc ), qp, nsucc, qpc, nfail ),
	       mkan( comb( 7, nsucc ), qpc, nsucc, qp, nfail ),
	       mkan( nsucc, qp, nsucc, qpc, nfail ),
	       mkan( nfail, qpc, nsucc, qp, nfail ),
	       mkan( nsucc, qpc, nsucc, qp, nfail ),
	       mkan( nfail, qp, nsucc, qpc, nfail ) }
   end
)
breakfast.chcFun = [[\chcLSix]]


-- function expectationHard()
--    local latextmpl = [[There are 
--    % d cashews and %d pistachios in a bag.  
--    You take one nut out at random and eat it, 
--    and repeat this until you get a %s.
--    Let \(X\) be the number of nuts you had to take in order to get the
--    first %s. For example, if you took out a %s, another
--    %s, and then a %s, \(X\) would be 3.
--    Find the expected value of \(X\).\\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local cash, pist = distinctRands( 2, 1, 3 )
--    local total = cash + pist
--    local names = { 'cashew', 'pistachio' }
--    local nums = { cash, pist }
--    local q = math.random( 2 )
--    local qname, oname = names[ q ], names[ 3 - q ]
--    local qnum, onum = nums[ q ], nums[ 3 - q ]
--    local ans = 0
--    for i = 0, onum do
--       ans = ans + ( i + 1 ) * frc.new( perm( onum, i ) * qnum, perm( total, i + 1 ) )
--    end
--    local anslst = { ans,
-- 		    ans + 1, ans - 1,
-- 		    ans / 2, ans * 2,
-- 		    ans / 3,
-- 		    1, 2, onum, onum + 1 }
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { cash, pist, qname, qname, 
-- 			      oname, oname, qname },
-- 			    chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    latex, _ = string.gsub( latex, '1 cashews', '1 cashew' )
--    latex, _ = string.gsub( latex, '1 pistachios', '1 pistachio' )
--    return latex  
-- end 

expectationHard = mp:new(
   [[There are 
   %s and %s in a bag.  
   You take one nut out at random and eat it, 
   and repeat this until you get a %s.
   Let \(X\) be the number of nuts you had to take in order to get the
   first %s. For example, if you took out a %s, another
   %s, and then a %s, \(X\) would be 3.
   Find the expected value of \(X\). ]],
   function( self )
      local cashpl, pistpl = mkPlural( 'cashew' ), mkPlural( 'pistachio' )
      local cash, pist = distinctRands( 2, 1, 3 )
      local total = cash + pist
      local names = { 'cashew', 'pistachio' }
      local nums = { cash, pist }
      local q = math.random( 2 )
      local qname, oname = names[ q ], names[ 3 - q ]
      local qnum, onum = nums[ q ], nums[ 3 - q ]
      local ans = 0
      for i = 0, onum do
	 ans = ans + ( i + 1 ) * frc.new( perm( onum, i ) * qnum, perm( total, i + 1 ) )
      end
      return { cashpl:ch(cash), pistpl:ch(pist), 
	       qname, qname, oname, oname, qname },
             { ans,
	       ans + 1, ans - 1,
	       ans / 2, ans * 2,
	       ans / 3,
	       1, 2, onum, onum + 1 }
   end 
)


-- function expectationEasy()
--    local latextmpl = [[A random variable \(X\) has the p.d.f.\ shown
--    below (with one probability missing). 

-- \begin{ctab}{rl}
-- \(X\) & \(\pr{X}\) \\
-- \midrule 
-- %d & %s \\
-- %d & %s \\
-- %d & %s \\
-- \end{ctab}

-- What is \(\ex(X)\)? \\
-- \\
-- \chcSix{\(%.1f\)}{\(%.1f\)}{\(%.1f\)}{\(%.1f\)}{\(%.1f\)}{\(%.1f\)} ]]

--    local x1, x2, x3 = distinctRands( 3, -5, 5 )
--    local xvec = vec.new( { x1, x2, x3 } )
--    local p1, p2 = distinctRands( 2, 1, 5 )
--    p1, p2 = p1/10, p2/10
--    local p3 = 1 - p1 - p2 
--    local probs = vec.new( { p1, p2, p3 } )
--    local missing = math.random( 3 )
--    local probstrs = map( probs, function (x) 
-- 			    return string.format( '%.1f', x ) 
-- 				end )
--    probstrs[ missing ] = '?'
--    local anslst = { probs * xvec,
-- 		    vec.new( { 1/3, 1/3, 1/3 } ) * xvec,
-- 		    1, 0,
-- 		    probs * vec.new( { math.abs( x1 ),
-- 				       math.abs( x2 ),
-- 				       math.abs( x3 ) } ),
-- 		    vec.new( { p1, p2, - p3 } ) * xvec,
-- 		    vec.new( { p1, p2, 0 } ) * xvec,
-- 		    vec.new( { p1, 0, p3 } ) * xvec,
-- 		    vec.new( { 0, p2, p3 } ) * xvec,
-- 		    vec.new( { p1, 0, 0 } ) * xvec,
-- 		    vec.new( { 0, 0, p3 } ) * xvec,
-- 		    vec.new( { 0, p2, 0 } ) * xvec,
-- 		    x1, x2, x3 }
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { x1, probstrs[1],
-- 			      x2, probstrs[2],
-- 			      x3, probstrs[3] },
-- 			    chclst )
--    return mklatex( latextmpl, sublst ) 
-- end 

expectationEasy = mp:new(
   { [[A random variable \(X\) has the p.d.f.\ shown
     below (with one probability missing). 

     \begin{ctab}{rl}
       \(X\) & \(\pr{X}\) \\
       \midrule 
       @x1 & @ps1 \\
       @x2 & @ps2 \\
       @x3 & @ps3 \\
     \end{ctab}

     What is \(\ex(X)\)? ]],

     [[ A random variable \(X\) can take only the values @x1, @x2, and
     @x3.  It is known that \({\pr{X=@kv1 }= @pkv1 }\) and 
     \({\pr{X=@kv2 }= @pkv2 }\).  What is the expected value of \(X\)?]] },

   function( self )
      local x1, x2, x3 = distinctRands( 3, -5, 5 )
      local xvec = vec.new( { x1, x2, x3 } )
      local p1, p2 = distinctRands( 2, 1, 5 )
      p1, p2 = p1/10, p2/10
      local p3 = 1 - p1 - p2 
      local probs = vec.new( { p1, p2, p3 } )
      local missing = math.random( 3 )
      k1 = missing + 1
      if k1 == 4 then k1 = 1 end
      k2 = 6 - missing - k1
      local probstrs = map( probs, function (x) 
			       return string.format( '%.1f', x ) 
				   end )
      probstrs[ missing ] = '?'
      return { x1=x1, ps1=probstrs[1], 
	       x2=x2, ps2=probstrs[2], 
	       x3=x3, ps3=probstrs[3],
	       kv1 = xvec[ k1 ], pkv1 = probstrs[ k1 ],
	       kv2 = xvec[ k2 ], pkv2 = probstrs[ k2 ] },
             { probs * xvec,
	       1, 0,
	       probs * vec.new( { math.abs( x1 ),
				  math.abs( x2 ),
				  math.abs( x3 ) } ),
	       vec.new( { p1, p2, - p3 } ) * xvec,
	       vec.new( { p1, p2, 0 } ) * xvec,
	       vec.new( { p1, 0, p3 } ) * xvec,
	       vec.new( { 0, p2, p3 } ) * xvec,
	       vec.new( { p1, 0, 0 } ) * xvec,
	       vec.new( { 0, 0, p3 } ) * xvec,
	       vec.new( { 0, p2, 0 } ) * xvec,
	       x1, x2, x3,
	       vec.new( { 1/2, 1/2, 1/4 } ) * xvec,
	       vec.new( { 1/2, 1/4, 1/2 } ) * xvec,
	       vec.new( { 1/4, 1/2, 1/2 } ) * xvec }
   end
)


-- function bayesStory()
--    local latextmpl = [[A grocery store gets turnips from two different
--    suppliers, Acme and US Produce.  Turnip shipments from Acme are
--    late %d\percent
--    of the time, while turnip shipments from US Produce are late
--    %d\percent
--    of the time.  The store orders %d\percent
--    of its shipments from Acme and the rest
--    of its shipments from US Produce.
--    Suppose that the current shipment of turnips happens to be %s.
--    What is the probability that it was ordered from %s? \\
--    \\
--    \chcSix{%s}{%s}{%s}{%s}{%s}{%s}]]
--    local p1, p2, p3 = distinctRands( 3, 1, 4 )
--    if randBool() then p1 = 10 - p1 end 
--    if randBool() then p2 = 10 - p2 end 
--    if randBool() then p3 = 10 - p3 end 

  
--    local oneqlst = { 'Acme', 'US Produce' }
--    local twoqlst = { 'late', 'on time' }
--    local anslst = { frc.new( p1 * p2, p1 * p2 + (10 - p1) * p3 ),
-- 		    frc.new( p1 * (10 - p2), p1 * (10 - p2) + (10 - p1) * (10 - p3) ),
-- 		    frc.new( (10 - p1) * p3, p1 * p2 + (10 - p1) * p3 ),
-- 		    frc.new( (10 - p1) * (10 - p3), p1 * (10 - p2) + (10 - p1) * (10 - p3) ) }
--    local wrong = { frc.new( p1 * p2, 100 ),
-- 		    frc.new( p1 * (10 - p2), 100 ),
-- 		    frc.new( (10 - p1) * p3, 100 ),
-- 		    frc.new( (10 - p1) * (10 - p3), 100 ) }
--    local qone, qtwo = math.random( 2 ), math.random( 2 )
--    local q = 2 * qone + qtwo - 2
--    local anslst = listJoin( { anslst[q] }, anslst, wrong )
--    local chclst = randPerm( distinctElems( 6, anslst ) )
--    local sublst = listJoin( { p2 * 10, p3 * 10, p1 * 10, 
-- 			       twoqlst[ qtwo ], oneqlst[ qone ] },
-- 			     chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex  
-- end 

bayesStory = mp:new(
{ [[A grocery store gets turnips from two different
  suppliers, Acme and US Produce.  Turnip shipments from Acme are
  late @p2\percent
  of the time, while turnip shipments from US Produce are late
  @p3\percent
  of the time.  The store orders @p1\percent
  of its shipments from Acme and the rest
  of its shipments from US Produce.
  Suppose that the current shipment of turnips @Q2.
  What is the probability that it was ordered from @Q1? ]],

  [[ The math department gets @p1\percent of its donuts from Kroger's 
  and the rest of its donuts from Marsh.
  Donuts from Kroger's give you
  indigestion @p2\percent of the time,
  while those from Marsh give you indigestion @p3\percent of the time.
  You eat a donut during a coffee break and later in
  the afternoon you feel @Q2.  What is the
  probability the donut you ate came from @Q1? ]] },
   function( self )
      local p1, p2, p3 = distinctRands( 3, 1, 4 )
      if randBool() then p1 = 10 - p1 end 
      if randBool() then p2 = 10 - p2 end 
      if randBool() then p3 = 10 - p3 end 

      
      local oneqlst = { { 'Acme', "Kroger's" },
			{ 'US Produce', "Marsh" } }
      local twoqlst = { { 'is late', 'indigestion coming on' },
			{ [[is {\em not} late]], 'just fine' } }
      local anslst = { frc.new( p1 * p2, p1 * p2 + (10 - p1) * p3 ),
		       frc.new( p1 * (10 - p2), p1 * (10 - p2) + (10 - p1) * (10 - p3) ),
		       frc.new( (10 - p1) * p3, p1 * p2 + (10 - p1) * p3 ),
		       frc.new( (10 - p1) * (10 - p3), p1 * (10 - p2) + (10 - p1) * (10 - p3) ) }
      local wrong = { frc.new( p1 * p2, 100 ),
		      frc.new( p1 * (10 - p2), 100 ),
		      frc.new( (10 - p1) * p3, 100 ),
		      frc.new( (10 - p1) * (10 - p3), 100 ) }
      local qone, qtwo = math.random( 2 ), math.random( 2 )
      local q = 2 * qone + qtwo - 2
      return { p2=p2 * 10, p3=p3 * 10, p1=p1 * 10, 
	       Q2=twoqlst[ qtwo ], Q1=oneqlst[ qone ] },
             listJoin( { anslst[ q ] }, anslst, wrong )
   end
)


-- function committeeOr()
--    local latextmpl = [[The Senate committee on Eduction has %d 
--    members, including Abner and Barbara.
--    A subcommittee of three is to be formed to investigate the growing
--    scandal in Finite Mathematics.  How many such subcommittees are
--    possible which would include either Abner, Barbara, or both?\\
--    \\
--    \chcSix{%d}{%d}{%d}{%d}{%d}{%d}]]

--    local size = math.random( 6, 12 )
--    local total = comb( size, 3 )
--    local cmpl = comb( size - 2, 3 )
--    local anslst = { total - cmpl,
-- 		    total, cmpl, size, comb( size, 2 ), 
-- 		    size + comb( size - 1, 2) * 2,
-- 		    comb( size - 2, 2) * 2,
-- 		    size + comb( size - 2, 2) }
--    local chclst = mkchc( anslst )
--    local sublst = listJoin( { size }, chclst )
--    local latex = string.format( latextmpl, table.unpack( sublst ) )
--    return latex  
-- end 

committeeOr = mp:new(
   [[The Senate committee on Education has @size
   members, including Abner and Barbara.
   A subcommittee of three is to be formed to investigate the growing
   scandal in Finite Mathematics.  How many such subcommittees are
   possible which would include @Q1 Abner @Q2 Barbara? ]],
   function( self, q )
      local size = math.random( 6, 12 )
      local total = comb( size, 3 )
      local cmpl = comb( size - 2, 3 )
      local qlst = { { 'exactly one of', 'and', 2 * comb( size - 2, 2 ) },
		     { 'either', 'or', total - cmpl } }
      q = q or math.random(2)
      return { size=size, Q1=qlst[ q ][1], Q2=qlst[ q ][2] },
             { qlst[ q ][3],
	       total - cmpl, 2 * comb( size - 2, 2 ),
	       comb( size - 2, 2 ), 2 * comb( size - 1, 2 ),
	       total, cmpl, size, comb( size, 2 ), 
	       size + comb( size - 1, 2) * 2,
	       comb( size - 2, 2) * 2,
	       comb( size - 1, 2 ),
	       size + comb( size - 2, 2) }
   end
)



-- function paradigms( q )
--    local latextmpl = [[There are %d 
--    rectangular plastic blocks, each one a different color from the
--    others.  How many ways are there 
--    %s? \\
--    \\ 
--    \chcSix{\(%s\)}{\(%s\)}{\(%s\)}{\(%s\)}{\(%s\)}{\(%s\)}]]
--    local tot = math.random( 5, 10 ) * 2
--    local sub = math.random( 3, 9 )
--    local qlst = { string.format( 'to build a tower %d blocks high', sub ),
-- 		  string.format( 'to give %d blocks to a friend', sub ),
-- 		  string.format( 'for %d friends to each name his/her favorite color', sub ),
-- 		  'to split them up into two equal piles',
-- 		  'to separate them into a left pile and a right pile' }
--    local anslst = { string.format( [[\prm( %d, %d )]], tot, sub ),
-- 		    string.format( [[\cmb( %d, %d )]], tot, sub ),
-- 		    string.format( [[%d^{%d}]], tot, sub ),
-- 		    string.format( [[\cmb( %d, %d )]], tot, tot/2 ),
--                     string.format( [[2^{%d}]], tot ) }
--    local wrong = { string.format( [[2^{%d}]], sub ),
-- 		   string.format( [[\prm( %d, %d )]], tot, tot ),
-- 		   string.format( [[\cmb( %d, %d )]], tot, tot ),
-- 		   string.format( [[\prm( %d, %d )]], sub, sub ),
-- 		   string.format( [[\cmb( %d, %d )]], sub, sub ) }
--    q = q or math.random( 5 )
--    anslst = listJoin( { anslst[ q ] }, anslst, wrong )
--    local chclst = mkchc( anslst )
--    local sublst = listJoin( { tot, qlst[ q ] }, chclst )
--    return mklatex( latextmpl, sublst )  
-- end 

paradigms = mp:new(
   [[There are %d 
   cubic plastic blocks, each one a different color from the
   others.  How many ways are there 
   %s? ]],
   function ( self, q )
      local tot = math.random( 5, 10 ) * 2
      local sub = math.random( 3, 9 )
      local qlst = { string.format( 'to build a tower %d blocks high', sub ),
		     string.format( 'to give %d blocks to a friend', sub ),
		     string.format( 'for %d friends to each name his/her favorite color', sub ),
		     'to split them up into two equal piles',
		     'to separate them into a left pile and a right pile' }
      local anslst = { string.format( [[\(\prm( %d, %d )\)]], tot, sub ),
		       string.format( [[\(\cmb( %d, %d )\)]], tot, sub ),
		       string.format( [[\(%d^{%d}\)]], tot, sub ),
		       string.format( [[\(\cmb( %d, %d )\)]], tot, tot/2 ),
		       string.format( [[\(2^{%d}\)]], tot ) }
      local wrong = { string.format( [[\(2^{%d}\)]], sub ),
		      string.format( [[\(\prm( %d, %d )\)]], tot, tot ),
		      string.format( [[\(\cmb( %d, %d )\)]], tot, tot ),
		      string.format( [[\(\prm( %d, %d )\)]], sub, sub ),
		      string.format( [[\(\cmb( %d, %d )\)]], sub, sub ) }
      q = q or math.random( 5 )
      return { tot, qlst[ q ] }, 
             listJoin( { anslst[ q ] }, anslst, wrong )
   end
)


-- function expectationLinearity()
--    local latextmpl = [[A kissed frog has a %d\percent
--    chance of turning into a prince, while a kissed toad has only a
--    %d\percent 
--    chance of turning into a prince.  If %d frogs and %d toads are
--    kissed, what is the expected number of princes produced?\\
--    \\
--    \chcSix{%.1f}{%.1f}{%.1f}{%.1f}{%.1f}{%.1f}]]
--    local fps = math.random( 2, 9 ) * 10
--    local tps = math.random( (fps - 10)/10 ) * 10
--    local fp, tp = fps/100, tps/100
--    local fn, tn = distinctRands( 2, 10, 20 )
--    local anslst = { fp * fn + tp * tn,
-- 		    (fn + tn) * ( fp + tp )/2,
-- 		    (fn + tn) * ( fp + tp ),
-- 		    (fn + tn) * fp,
-- 		    (fn + tn) * tp,
-- 		    fn * fp,
-- 		    tn * tp }
--    local chclst= mkchc( anslst )
--    local sublst = listJoin( { fps, tps, fn, tn },
-- 			    chclst )
--    return mklatex( latextmpl, sublst )
-- end

expectationLinearity = mp:new(
   { [[A kissed frog has a @fps\percent
     chance of turning into a prince, while a kissed toad has only a
     @tps\percent 
     chance of turning into a prince.  If @fn frogs and @tn toads are
     kissed, what is the expected number of princes produced? ]],

     [[ A gray mouse has a @fps\percent chance of stealing cheese from
     a mousetrap without getting caught, while a white mouse has a 
     @tps\percent chance of succeeding at that.  If @fn gray mice and 
     @tn white mice try to steal cheese from  
     different traps, how many
     pieces of cheese would you expect them to get away with? ]] },
   
   function( self )
      local fps = math.random( 2, 9 ) * 10
      local tps = math.random( (fps - 10)/10 ) * 10
      local fp, tp = fps/100, tps/100
      local fn, tn = distinctRands( 2, 10, 20 )
      return { fps=fps, tps=tps, fn=fn, tn=tn, total = fn + tn },
             { fp * fn + tp * tn,
	       (fn + tn) * ( fp + tp )/2,
	       (fn + tn) * ( fp + tp ),
	       (fn + tn) * fp,
	       (fn + tn) * tp,
	       fn * fp,
	       tn * tp }
   end
)


-- function houseSubcom( total, sub )
--    local tmpl = [[A House committee has %d members, %d Republicans and
--    %d Democrats.
--    A budget group is going to be formed consisting of 
--    %d Republicans and %d Democrats.
--    How many ways are there to choose the members on the budget group?
--    \\ \\ 
--    \chcSix{%d}{%d}{%d}{%d}{%d}{%d}]]
--    local dems = math.random( 2, math.floor( total / 2 ) )
--    local reps = total - dems
--    local gd = math.random( 2, math.floor( sub / 2 ) )
--    local gr = sub - gd
--    local anslst = { comb( reps, gr ) * comb( dems, gd ),
-- 		    perm( reps, gr ) * perm( dems, gd ),
-- 		    comb( reps, gr ), comb( dems, gd ),
-- 		    perm( reps, gr ), perm( dems, gd ),
-- 		    gr * gd, reps * dems }
--    local chclst = mkchc( anslst )
--    local sublst = listJoin( { total, reps, dems, gr, gd }, chclst )
--    local latex = string.format( tmpl, table.unpack( sublst ) )
--    latex = string.gsub( latex, '1 Democrats', '1 Democrat' )
--    return latex  
-- end 

houseSubcom = mp:new(
   [[A House committee has %d members, %d Republicans and
   %d Democrats.
   A budget group is going to be formed consisting of 
   %d Republicans and %s.
   How many ways are there to choose the members on the budget group?
   ]],
      function( self, total, sub, dems, gd )
	 local dempl = mkPlural( 'Democrat' )
	 dems = dems or math.random( 2, math.floor( total / 2 ) )
	 local reps = total - dems
	 gd = gd or math.random( 2, math.floor( sub / 2 ) )
	 local gr = sub - gd
	 return { total, reps, dems, gr, dempl:ch( gd ) },
	        { comb( reps, gr ) * comb( dems, gd ),
		  perm( reps, gr ) * perm( dems, gd ),
		  comb( reps, gr ), comb( dems, gd ),
		  perm( reps, gr ), perm( dems, gd ),
		  gr * gd, reps * dems }
      end
)

-- function setAlgebra()
--    local tmpl = [[Given the following sets
--    \[\begin{array}{lcr}
--      X &=& %s \\
--      Y &=& %s \\
--      Z &=& %s 
--    \end{array}\]
--    in the universe \(U=%s\), what is \((X%s%s Y%s)%s Z%s\)? \\
--    \\
--    \chcLSix{\(\{%s\}\)}{\(\{%s\}\)}{\(\{%s\}\)}{\(\{%s\}\)}{\(\{%s\}\)}{\(\{%s\}\)}]]
--    local elems = { 'a', 'b', 'c', 'd', 'e' }
--    local U = st:new( elems )
--    local X, Y, Z = U:random(), U:random(), U:random()
--    local compl = math.random( 3 )
--    local cmplst = { '', '', '' }
--    cmplst[ compl ] = [[']]
--    local sets = { X, Y, Z }
--    sets[ compl ] = U - sets[ compl ]

--    local ops = { [[\cap]], [[\cup]] }
--    local q1, q2 = math.random( 2 ), math.random( 2 )
--    local q = 2 * q1 + q2 - 2
--    local anslst = { (( sets[1] * sets[2] ) * sets[3]),
-- 		    (( sets[1] * sets[2] ) + sets[3]),
-- 		    (( sets[1] + sets[2] ) * sets[3]),
-- 		    (( sets[1] + sets[2] ) + sets[3]) }
--    local wrong = { (( X * Y ) * Z),
-- 		   (( X * Y ) + Z),
-- 		   (( X + Y ) + Z),
-- 		   (( X + Y ) * Z),
-- 		   U:random(), U:random(), U:random() }
--    local chclst = mkchc( listJoin( { anslst[ q ] }, anslst, wrong ) )
--    local sublst = listJoin( { X:tolatex(), Y:tolatex(), Z:tolatex(), 
-- 			      U:tolatex(),
-- 			      cmplst[1], ops[ q1 ], cmplst[2], 
-- 			      ops[ q2 ], cmplst[3] },
-- 			    chclst )
--    return mklatex( tmpl, sublst )
-- end 

setAlgebra = mp:new(
   [[Given the following sets
   \[\begin{array}{lcr}
     X &=& %s \\
     Y &=& %s \\
     Z &=& %s 
   \end{array}\]
   in the universe \(U=%s\), what is \((X%s%s Y%s)%s Z%s\)? ]],
   function ( self )
      local elems = { 'a', 'b', 'c', 'd', 'e' }
      local U = st:new( elems )
      local X, Y, Z = U:random(true), U:random(true), U:random(true)
      local compl = math.random( 3 )
      local cmplst = { '', '', '' }
      cmplst[ compl ] = [[']]
      local sets = { X, Y, Z }
      sets[ compl ] = U - sets[ compl ]

      local ops = { [[\cap]], [[\cup]] }
      local q1, q2 = math.random( 2 ), math.random( 2 )
      local q = 2 * q1 + q2 - 2
      local anslst = { (( sets[1] * sets[2] ) * sets[3]),
		       (( sets[1] * sets[2] ) + sets[3]),
		       (( sets[1] + sets[2] ) * sets[3]),
		       (( sets[1] + sets[2] ) + sets[3]) }
      local wrong = { (( X * Y ) * Z),
		      (( X * Y ) + Z),
		      (( X + Y ) + Z),
		      (( X + Y ) * Z),
		      U:random(), U:random(), U:random(),
		      U:random(), U:random(), U:random() }
      return { X:tolatex(), Y:tolatex(), Z:tolatex(), U:tolatex(),
	       cmplst[1], ops[ q1 ], cmplst[2], 
	       ops[ q2 ], cmplst[3] },
               mp.listToLatex( listJoin( { anslst[ q ] }, 
					 anslst, wrong ) )
   end,
   [[\chcLSix]]
)



-- function weightsInEvents()
--    local tmpl = [[A sample space consists of just three outcomes,
--    denoted \(\mathcal{O}_1\), \(\mathcal{O}_2\), and
--    \(\mathcal{O}_3\).  Events \(E\), \(F\), and \(G\) are defined as 
--    \[ E = \{\,\mathcal{O}_1,\mathcal{O}_2\,\} \qquad 
--    F =\{\,\mathcal{O}_2,\mathcal{O}_3\,\} \qquad
--    G = \{\,\mathcal{O}_1,\mathcal{O}_3\,\}\]
--    If \(\pr{E}=%.2f\) and \(\pr{F}=%.2f\), 
--    what is \(\pr{G}\)?\\
--      \\
--      \chcSix{%.2f}{%.2f}{%.2f}{%.2f}{%.2f}{%.2f}]]
--    local p1, p2 = distinctRands( 2, 20, 49 )
--    while 2*p1+p2 == 100 or p1+2*p2 == 100 do p1, p2 = distinctRands( 2, 20, 50 ) end
--    p1, p2 = p1/100, p2/100
--    local p3 = 1 - p1 - p2
--    local pre, prf = p1 + p2, p2 + p3
--    local anslst = { p1 + p3 }
--    local wrong = { p1, p2, p3,
-- 		   p1 + p2, p1 + p3, p2 + p3,
-- 		   1 - p1, 1 - p2, 1 - p3 }
--    local chclst = mkchc( listJoin( anslst, wrong ) )
--    local sublst = listJoin( { pre, prf, q }, chclst )
--    return mklatex( tmpl, sublst )
-- end

weightsInEvents = mp:new(
   [[A sample space consists of just three outcomes,
   denoted \(\mathcal{O}_1\), \(\mathcal{O}_2\), and
   \(\mathcal{O}_3\).  Events \(E\), \(F\), and \(G\) are defined as 
   \[ E = \{\,\mathcal{O}_1,\mathcal{O}_2\,\} \qquad 
   F =\{\,\mathcal{O}_2,\mathcal{O}_3\,\} \qquad
   G = \{\,\mathcal{O}_1,\mathcal{O}_3\,\}\]
   If \(\pr{E}=%.2f\) and \(\pr{F}=%.2f\), 
   what is \(\pr{G}\)?]],
   function ( self )
      local p1, p2 = distinctRands( 2, 20, 49 )
      while 2*p1+p2 == 100 or p1+2*p2 == 100 do p1, p2 = distinctRands( 2, 20, 50 ) end
      p1, p2 = p1/100, p2/100
      local p3 = 1 - p1 - p2
      local pre, prf = p1 + p2, p2 + p3
      return { pre, prf, q },
             { p1 + p3,
	       p1, p2, p3,
	       1 - p1, 1 - p2, 1 - p3,
	       0, 1 }
   end
)


-- function uglyTree(  )
--    local tmpl= [[You have a bag of poker chips, containing 
--    %d white, %d red, and %d blue chips.
--    White chips are worth
--    \$1, red chips are worth \$%d
--    and blue chips are worth \$%d.
--    You need \$%d worth of chips in order to buy lunch,
--    so you take chips out of the bag one at a time, noting the color of
--    each one as it's removed, and stop when the total value of the
--    chips removed is at least \$%d.
--    How many sequences of chip colors are possible when you do this?\\
--    \\
--    \chcSix{%d}{%d}{%d}{%d}{%d}{%d}]]
--    local nw, nr, nb = distinctRands( 3, 1, 4)
--    local vr, vb = math.random( 2, 3), math.random( 2 ) * 5
--    local vals = { 1, vr, vb }
--    local raise = math.random( 4, 14 )
--    local anslst = { treeSize( raise, { nw, nr, nb }, vals ),
-- 		    treeSize( raise - 1, { nw, nr, nb }, vals ),
-- 		    treeSize( raise + 1, { nw, nr, nb }, vals ),
-- 		    treeSize( raise, { nw, nr, nb }, {1,1,1} ),
-- 		    treeSize( raise, { nw - 1, nr, nb }, vals ),
-- 		    treeSize( raise, { nw, nr - 1, nb }, vals ),
-- 		    treeSize( raise, { nw, nr, nb - 1 }, vals ),
-- 		    treeSize( raise, { nw + 1, nr, nb }, vals ),
-- 		    treeSize( raise, { nw, nr + 1, nb }, vals ),
-- 		    treeSize( raise, { nw, nr, nb + 1 }, vals ) }
--    local chclst = mkchc( anslst )
--    local sublst = listJoin( { nw, nr, nb,
-- 			      vr, vb, raise, raise },
-- 			    chclst )
--    return mklatex( tmpl, sublst )
-- end

--too hard?
uglyTree = mp:new(
   [[You have a bag of poker chips, containing 
   %d white, %d red, and %d blue chips.
   White chips are worth
   \$1, red chips are worth \$%d
   and blue chips are worth \$%d.
   You need \$%d worth of chips in order to see someone's raise,
   so you take chips out of the bag one at a time, noting the color of
   each one as it's removed, and stop when the total value of the
   chips removed is at least \$%d.
   How many sequences of chip colors are possible when you do this? ]],
   function( self )
      local nw, nr, nb = distinctRands( 3, 1, 3)
      --local vr, vb = math.random( 2, 3), math.random( 1 ) * 5
      local vr, vb = 3, 5
      local vals = { 1, vr, vb }
      local raise = math.random( 6, 9 ) - nw
      return { nw, nr, nb, vr, vb, raise, raise },
             { treeSize( raise, { nw, nr, nb }, vals ),
	       treeSize( raise - 1, { nw, nr, nb }, vals ),
	       treeSize( raise + 1, { nw, nr, nb }, vals ),
	       treeSize( raise, { nw, nr, nb }, {1,1,1} ),
	       treeSize( raise, { nw - 1, nr, nb }, vals ),
	       treeSize( raise, { nw, nr - 1, nb }, vals ),
	       treeSize( raise, { nw, nr, nb - 1 }, vals ),
	       treeSize( raise, { nw + 1, nr, nb }, vals ),
	       treeSize( raise, { nw, nr + 1, nb }, vals ),
	       treeSize( raise, { nw, nr, nb + 1 }, vals ) }
   end
)


conditionalGiven = mp:new( 
   [[\(E\) and \(F\) are events such that 
   \[\begin{array}{rcl}
     \pr{E} &=& %.1f \\
     \cpr{F}{E} &=& %.1f \\
     \cpr{F}{E'} &=& %.1f
   \end{array}\]
   Find \(\pr{F}\).]],
   function ()
      local nums = { 1,2,3,4,6,7,8,9 }
      local prE = randElem( nums ) / 10
      local cprFE, cprFe = randElem( nums ) / 10, randElem( nums ) / 10
      while cprFE == cprFe or cprFE == 1 - cprFe do cprFe = randElem( nums ) / 10 end
      local qlst = { prE, cprFE, cprFe }
      local anslst = { prE * cprFE + ( 1 - prE ) * cprFe,
		       prE * cprFe + ( 1 - prE ) * cprFE,
		       prE * cprFE, prE * cprFe,
		       (1 - prE) * cprFE, (1 - prE) * cprFe,
		       cprFE + cprFe,
		       cprFE, cprFe }
      return qlst, anslst
   end
 )


subsetCount = mp:new(
   [[A set \(S\) has @ns elements.
   How many subsets of \(S\) are there with 
   @qstr @lim elements?  
   Don't forget the empty set!]],
   function ( self, ns, lim )
      local s = self
      ns = ns or math.random( 6, 10 )
      lim = lim or 2
      _ENV.ns, _ENV.lim = ns, lim
      local mostQ = randBool()
      qstr = 'at most'
      -- if randBool() then 
      -- 	 qstr = 'at least'
      -- 	 lim = ns - lim
      -- end
      --local subs = { ns, qstr, lim }
      local ans = 0 
      local minlim = math.min( lim, ns - lim )
      for i = 0, minlim do
	 ans = ans + comb( ns, i )
      end
      local wrong1 = ans + comb( ns, minlim + 1 )
      local wrong2 = ans - comb( ns, minlim )
      local anslst = { ans, wrong1, wrong2,
		       comb( ns, lim ), ns, lim,
		       ans - 1, wrong1 - 1, wrong2 - 1 }
      return anslst
   end
)
--subsetCount.subFun = 'self'

-- Too easy to get the right answer by mistake!
colorsThree = mp:new(
   [[In a pet shop there are six snakes of different colors:
   %d %s, %d %s, and %d %s.
   One of the snakes is sold on Monday, and another is sold on
   Tuesday. If the snake sold on Tuesday was %s,
   what is the probability that the snake sold on Monday was %s?]],
   function()
      local colors = { 'red', 'green', 'yellow' }
      local n1, n2, n3 = distinctRands( 3, 1, 3 )
      local q1, q2 = distinctRands( 2, 1, 3 )
      local q3 = 6 - q1 - q2
      local qsubs = { n1, colors[1], n2, colors[2], n3, colors[3],
		      colors[ q1 ], colors[ q2 ] }
      local tree = { { frc.new( n1, 6 ), { frc.new( n1 - 1, 5 ),
					   frc.new( n2, 5 ),
					   frc.new( n3, 5 ) } },
		     { frc.new( n2, 6 ), { frc.new( n1, 5 ),
					   frc.new( n2 - 1, 5 ),
					   frc.new( n3, 5 ) } },
		     { frc.new( n3, 6 ), { frc.new( n1, 5 ),
					   frc.new( n2, 5 ),
					   frc.new( n3 - 1, 5 ) } } }
      local denom = tree[ q2 ][1] * tree[ q2 ][2][ q1 ] + tree[ q1 ][1] * tree[ q1 ][2][ q1 ] + tree[ q3 ][1] * tree[ q3 ][2][ q1 ]
      local wd1 = tree[ q2 ][1] * tree[ q2 ][2][ q2 ] + tree[ q1 ][1] * tree[ q1 ][2][ q2 ] + tree[ q3 ][1] * tree[ q3 ][2][ q2 ]
      local wd2 = tree[ q2 ][1] * tree[ q2 ][2][ q3 ] + tree[ q1 ][1] * tree[ q1 ][2][ q3 ] + tree[ q3 ][1] * tree[ q3 ][2][ q3 ]

      local numer = tree[ q2 ][1] * tree[ q2 ][2][ q1 ]
      local wn1 = tree[ q1 ][1] * tree[ q1 ][2][ q1 ]
      local wn2 = tree[ q3 ][1] * tree[ q3 ][2][ q1 ]
      local anslst = { numer / denom,
		       numer,
		       tree[ q2 ][1],
		       1 - ( numer / denom ),
		       wn1 / wd1,
		       wn2 / wd2,
		       denom,
		       wd1, wd2, wn1, wn2 }
      anslst = mp.listToLatex( anslst )
      return qsubs, anslst
   end
)


sockMatch = mp:new(
   [[You have a draw that contains %d socks in three different colors:
   %d %s, %d %s, and %d %s.
   You take take out two socks at random and put them on.  You then
   notice that both socks are the same color.  What's the probability
   that both socks are %s?]],
   function ( self )
      local cols = { 'black', 'white', 'blue' }
      local n1, n2, n3 = distinctRands( 3, 2, 6 )
      local nums = { n1, n2, n3 }
      local tot = n1 + n2 + n3
      local q = math.random( 3 )
      local qsubs = { tot, 
		      n1, cols[1], n2, cols[2], n3, cols[3], 
		      cols[ q ] }
      local c1, c2, c3 = comb( n1, 2 ), comb( n2, 2 ), comb( n3, 2 )
      local cc = comb( nums[ q ], 2 )
      local ss = comb( tot, 2 )
      local denom = c1 + c2 + c3
      local anslst = { frc.new( cc, denom ),
		       frc.new( c1, denom ), 
		       frc.new( c2, denom ), 
		       frc.new( c3, denom ),
		       frc.new( n1, tot ),
		       frc.new( n2, tot ),
		       frc.new( n3, tot ),
		       frc.new( n1, tot * 2 ),
		       frc.new( n2, tot * 2 ),
		       frc.new( n3, tot * 2 ),
		       frc.new( 1, c1 ),
		       frc.new( 1, c2 ),
		       frc.new( 1, c3 ) }
      anslst = mp.listToLatex( anslst )
      return qsubs, anslst
   end
)

-- numbers too big?
permCompl = mp:new(
   [[A Senate committee has @nd Democrats and @nr Republicans.
   A secretary, treasurer, and sergeant-at-arms must be named from the
   committee members in such a way that each party gets at least one
   of the three offices.  If each office must be occupied by a distinct
   member, how many ways are there to name people to the three
   offices?  ]],
   function ( self, nr, tot )
      tot = tot or 7
      nr = nr or math.random( 2, math.floor( tot/2 ) + 1 )
      _ENV.tot, _ENV.nr = tot, nr
      nd = tot - nr
      local tot = nd + nr
      local ss = perm( tot, 3 )
      local ar, ad = perm( nr, 3 ), perm( nd, 3 )
      return { ss - ar - ad,
	       ss - ar, ss - ad,
	       ss, ar, ad, ar + ad,
	       ss - ar - ad - 6 * comb( nd, 2 ) * nr,
	       ss - ar - ad - 6 * comb( nr, 2 ) * nd }
   end
)
--permCompl.subFun = 'self'




