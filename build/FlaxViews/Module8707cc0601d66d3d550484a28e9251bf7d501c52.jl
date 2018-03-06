module Module8707cc0601d66d3d550484a28e9251bf7d501c52 
using Flax
export func_8707cc0601d66d3d550484a28e9251bf7d501c52 
function func_8707cc0601d66d3d550484a28e9251bf7d501c52() 
Flax.skip_element()  do;[ 
	Flax.skip_element()  
	Flax.skip_element()  do;[ 
		Flax.div(Symbol("class") => "page-header" )  do;[ 
			Flax.form(Symbol("class") => "form-horizontal" )  do;[ 
				Flax.div(Symbol("class") => "form-group form-group-lg" )  do;[ 
									Flax.input(Symbol("name") => "q" , Symbol("autofocus") => "" , Symbol("class") => "form-control col-md-12" , Symbol("id") => "txtSearch" , Symbol("onkeyup") => "this.value = (this.value.startsWith('#') ? this.value.substr(1) : this.value)" , Symbol("value") => "$( escape_string(@vars(:search_term)) )" , Symbol("placeholder") => "Explore Twitter Data: search for a hash to see stats" , Symbol("type") => "search" )  
					 include_template("app/layouts/shared/recent_searches.flax.html")  

 				]end 

 			]end 

 		]end 

 	]end 

 ]end 
end 
end