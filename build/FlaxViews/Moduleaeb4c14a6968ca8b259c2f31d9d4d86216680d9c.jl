module Moduleaeb4c14a6968ca8b259c2f31d9d4d86216680d9c 
using Flax
export func_aeb4c14a6968ca8b259c2f31d9d4d86216680d9c 
function func_aeb4c14a6968ca8b259c2f31d9d4d86216680d9c() 
Flax.skip_element()  do;[ 
	Flax.skip_element()  
	Flax.skip_element()  do;[ 
			Flax.div(Symbol("class") => "container" )  do;[ 
					Flax.div(Symbol("class") => "row" , Symbol("style") => "display: $(@vars(:search_term) != "" ? "block" : "none")" )  do;[ 
										Flax.div(Symbol("class") => "col-md-6" )  do;[ 
					Flax.canvas(Symbol("id") => "tweets-chart" ) 
 				]end 
 
				Flax.div(Symbol("class") => "col-md-3" )  do;[ 
					Flax.canvas(Symbol("id") => "polarity-chart" ) 
 				]end 
 
				Flax.div(Symbol("class") => "col-md-3" )  do;[ 
					Flax.canvas(Symbol("id") => "subjectivity-chart" ) 
 				]end 

 			]end 
 
			Flax.div(Symbol("class") => "row" )  do;[ 
				Flax.ul(Symbol("class") => "list-group" , Symbol("id") => "tweets_list" , Symbol("style") => "height: 600px; overflow: scroll;" )  do;[ 
					
        foreachvar(:tweet, @vars(:tweets)) do (_)
          include_template("app/resources/tweets/views/partials/tweet.flax.html")
        end
       
					Flax.li()  do;[ 
						Flax.h4()  do;[ 
							Flax.center()  do;[ 
																						Flax.br()  
								"
            Waiting for tweets...
            " 
								Flax.div(Symbol("class") => "uil-ripple-css" , Symbol("style") => "transform:scale(0.6);" )  do;[ 
																	Flax.div()  
									Flax.div() 
 								]end 

 							]end 

 						]end 

 					]end 

 				]end 

 			]end 

 		]end 
 
		Flax.script()  do;[ 
			"
  var search_term = '$( @vars(:search_term) )';
  var polarity = $( @vars(:polarity) );
  var subjectivity = $( @vars(:subjectivity) );
  var favorites = $( @vars(:favorites_count) );
  var retweets = $( @vars(:retweets_count) );
"
 		]end 

 	]end 

 ]end 
end 
end