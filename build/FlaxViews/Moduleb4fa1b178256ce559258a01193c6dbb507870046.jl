module Moduleb4fa1b178256ce559258a01193c6dbb507870046 
using Flax
export func_b4fa1b178256ce559258a01193c6dbb507870046 
function func_b4fa1b178256ce559258a01193c6dbb507870046() 
Flax.html(Symbol("lang") => "en-US" )  do;[ 
	Flax.head()  do;[ 
				Flax.meta(Symbol("charset") => "utf-8" )  
		Flax.title()  do;[ 
			"Genie :: The highly productive Julia web framework"
 		]end 
 
		Flax.link(Symbol("rel") => "stylesheet" , Symbol("href") => "/css/application.css" ) 
 	]end 
 
	Flax.body()  do;[ 
			Flax.div(Symbol("class") => "container" )  do;[ 
			
      include_template("app/layouts/shared/nav.flax.html")
      include_template("app/layouts/shared/hero.flax.html")
      @yield
     

 		]end 
 
		Flax.script(Symbol("src") => "/js/application.js" ) 
 	]end 

 ]end 
end 
end