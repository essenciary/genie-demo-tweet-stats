module Module2e03d893974211738ea4eebc1f4e63dba37d607a 
using Flax
export func_2e03d893974211738ea4eebc1f4e63dba37d607a 
function func_2e03d893974211738ea4eebc1f4e63dba37d607a() 
Flax.skip_element()  do;[ 
	Flax.skip_element()  
	Flax.skip_element()  do;[ 
		Flax.li(Symbol("class") => "list-group-item" , Symbol("id") => "tweet_$( @vars(:tweet).id |> Base.get )" )  do;[ 
			Flax.div(Symbol("class") => "row" )  do;[ 
							Flax.div(Symbol("class") => "col-sm-1 col-xs-2" )  do;[ 
					Flax.img(Symbol("alt") => "user" , Symbol("class") => "img-circle" , Symbol("src") => "$(@vars(:tweet).avatar_url)" ) 
 				]end 
 
				Flax.div()  do;[ 
																																	 @vars(:tweet).user_name  
					" @" 
					 @vars(:tweet).screen_name  
					"  
      " 
					 @vars(:tweet).text  
					"  
      " 
					 sentiment_labels(@vars(:tweet).polarity)  
					"  
      " 
					 subjectivity_labels(@vars(:tweet).subjective)  
					"  
      " 
					Flax.span(Symbol("aria-hidden") => "true" , Symbol("class") => "glyphicon glyphicon-retweet label label-default retweet-count" )  do;[ 
						Flax.span(Symbol("class") => "item-count" )  do;[ 
							 @vars(:tweet).retweet_count  

 						]end 

 					]end 
 
					"  
      " 
					Flax.span(Symbol("aria-hidden") => "true" , Symbol("class") => "glyphicon glyphicon-heart label label-default favorite-count" )  do;[ 
						Flax.span(Symbol("class") => "item-count" )  do;[ 
							 @vars(:tweet).favorite_count  

 						]end 

 					]end 

 				]end 

 			]end 

 		]end 

 	]end 

 ]end 
end 
end