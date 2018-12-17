
*Artigo Trabalho

foreach stub in 11/17 21/29 31/33 35 41/43 50/53 {  
infix estado 1-2 municipio 12-18 areaponderacao 51-63 sexo educacao 168-169 peso 335-345 cor idade rendimento frequenta 153-154 ///
using "D:\artigo trabalho\censo 2000\estados\Pes`stub'.txt"
save "D:\artigo trabalho\censo 2000\estados\uf`stub'.dta"
}

use "D:\artigo trabalho\censo 2000\estados\uf11.dta", clear 
foreach stub in 12/17 21/29 31/33 35 41/43 50/53 {  
append using "D:\artigo trabalho\censo 2000\estados\uf`stub'.dta"
}
save "D:\artigo trabalho\censo 2000\estados\censodoismi.dta" , replace

* Geoda

merge m:m municipio using d:geoda.dta 
drop _merge 



*Agregação Municipio

by municipio, sort: egen schooling = mean(educacao)
by municipio, sort: egen age = mean(idade)




collapse (mean) schooling, by (municipio)

save "D:\artigo trabalho\censo 2000\estados\censodoismilmunicipio.dta" , replace

*Agregação area ponderavel

use "D:\artigo trabalho\censo 2000\estados\censodoismi.dta", clear

by areaponderacao, sort: egen schooling = mean(educacao)

collapse (mean) schooling, by (areaponderacao)

* Estatistica Descritiva

mean educacao [fw=peso], over(municipio)



* Regressões

drop if frequenta !=.



