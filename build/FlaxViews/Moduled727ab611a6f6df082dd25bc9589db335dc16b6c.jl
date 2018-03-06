module Moduled727ab611a6f6df082dd25bc9589db335dc16b6c 
using Flax
export func_d727ab611a6f6df082dd25bc9589db335dc16b6c 
function func_d727ab611a6f6df082dd25bc9589db335dc16b6c() 
Flax.skip_element()  do;[ 
	Flax.skip_element()  
	Flax.skip_element()  do;[ 
			Flax.sup()  do;[ 
			"Or try a recent search:"
 		]end 
 
		Flax.ul(Symbol("class") => "btn-group btn-group-xs" , Symbol("style") => "margin-left: -40px" )  do;[ 
					 foreachvar(:search, @vars(:recent_searches)) do (search)  
			Flax.li(Symbol("role") => "presentation" , Symbol("class") => "btn btn-link" )  do;[ 
				Flax.a(Symbol("href") => "/?q=$(search.search)" )  do;[ 
					 search.search  

 				]end 

 			]end 
 
			 end  

 		]end 

 	]end 

 ]end 
end 
end