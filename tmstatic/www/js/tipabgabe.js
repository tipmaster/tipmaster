/**
 * 
 */
    var formularhash = [];
    var tiparray = [];
    var active_quote = "";
    
    $(document).ready(function(){
    	checkIE();
    	populate_formular();
    	build_tiptarget();
    	
    });
 
    $(document).keydown(function(event) {
    	if (event.keyCode >= 49 && event.keyCode <=52) {
    		// see if we hover over a tipquote
    		var j = $("#"+active_quote);
    		
			 var tip_id = active_quote.match(/q(\d)_(\d*)/);
			 var prognose = RegExp.$1;
			 var formgame_id = RegExp.$2


			 var spnum = event.keyCode-48;
			 //alert('Match '+spnum+' contains game '+matchnr+' with prognose '+prognose);
				// find out how many sp are populated in spnum
				var try_nr = 1; var found = false;
				while (!found) {
					var test_id = 's_'+spnum+'_t_'+try_nr;
					if ($('#'+test_id).text() == '') {
						found = true;
					} else {
						try_nr++;
					}
				}
			
			//number of open games in the tip
			var anzgames = $("#tips_"+spnum).attr("anztips");
				
			if (try_nr > 0 && try_nr <= anzgames) {
				addtip(spnum, try_nr ,formgame_id , prognose);
			} else {
				alert("Kein Tip mehr frei in Spiel "+spnum);
			}
			
    	}
    });
    
    function checkIE() {
    	var IE='\v'=='v';
    	//alert("UserAgent: "+navigator.userAgent);
    	if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
    		 var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
    		 if (ieversion>=9)
    		 IE=true;
    	}
    		  
    	if (IE) {
    		alert("Die neue Tipabgabe funktioniert leider nicht mit dem Internet Explorer");
    		window.location="/cgi-mod/tmi/login.pl";
    	} else {
    		//alert("Alles ok.");
    	}
    }
    
    function addtip(tipspiel_nr,tipspiel_tipnr,formgame_id,prognose) {
			 var match = $('#sp_'+formgame_id);
			 var quote = $('#q'+prognose+'_'+formgame_id).text();
			 var textfield = $('#s_'+tipspiel_nr+'_t_'+tipspiel_tipnr);
			 //alert("Formgame_id is "+formgame_id+" and match is "+match.text());
			 
				 tiparray[textfield.attr('id')] = {'form_id':match.attr('id'),
						 				  'prognose':prognose,
						 				  'quote':quote};

				 textfield.text( match.text());
				 textfield.next().text( prognose)
				 .next().text( quote );
				 
				 textfield.prev().children('button').show();   					// the delete button 
				 textfield.prev().children('span').hide();

				 
				 // make home quotes unavailable
				 var quote_tds = match.siblings().children(".drp");
				 quote_tds.draggable( "option", "disabled", true ); 
				 quote_tds.removeClass('quote_available');
				 quote_tds.addClass('quote_unavailable');
				
				// remove droppable here.
				textfield.droppable( "option","disabled","true").removeClass('ui-state-disabled');
				check_submit_valid();
				recalc_tipsums();
    }
    
    function populate_tiparray() {
    	$("#postform input").each( function() {
    		var tvalue = $(this).val();
    		var spname = $(this).attr('name');
    		if (spname.match(/(\d+)\.\.\.\./)) {
    			var matchnr = eval(RegExp.$1 - 19);
    			tvalue.match(/(\d)&(\d)/);
    			var spnum = RegExp.$1;
    			var prognose = wert2prognose(RegExp.$2);
    			if (spnum > 0) {
    				//alert('Match '+spnum+' contains game '+matchnr+' with prognose '+prognose);
    				// find out how many sp are populated in spnum
    				var try_nr = 1; var found = false;
    				while (!found) {
    					var test_id = 's_'+spnum+'_t_'+try_nr;
    					if ($('#'+test_id).text() == '') {
    						found = true;
    					} else {
    						try_nr++;
    					}
    				}
    				//alert("First open tip: "+try_nr+' -> '+spnum+"_"+try_nr+" filled with "+matchnr);
    				addtip(spnum,try_nr,matchnr,prognose);
    			}
    		}
    	});
    }
    
    function submit_form() {
    	//first, reset all tips.
    	for (var lfd=30; lfd<55; lfd++) {
    		$("#postform input[name='"+lfd+"....']").val("0&0");
    	}
    	//alert("Now filling form");
    	// fill the form with current tips
    	for (var key in tiparray) {
    		var val = tiparray[key];
    		
    		val.form_id.match(/sp_(\d*)/);
    		var spiel_id = RegExp.$1;
    		
			var which_tip = key.match(/s_(\d)_t_(\d)/);
			var tipspiel_nr = RegExp.$1;
			var tipspiel_tipnr = RegExp.$2;
			var val_wert = prognose2wert(val.prognose);
			var nom = spiel_id*1 + 19;
			$("#postform input[name='"+nom+"....']").val(tipspiel_nr+"&"+val_wert);
			//alert("name="+nom+".... value="+tipspiel_nr+"&"+val_wert);

    	}
    }
    
    function wert2prognose(wert) {
    	var to_ret = prognose2wert(wert-1)-1;
    	return to_ret;
    }
    function prognose2wert(wert) {
    	var to_ret = (1.5*wert*wert)-(2.5*wert)+2;
    	
    	return to_ret;
    }
    
    function setTipSum(tip_index) {
    	// add up sums from tiptable
    	var sum_tips = 0;
    	$("#tips_"+tip_index+" .lfdtip_quote").each( function() {
    		sum_tips += ($(this).text()*1);
    	});
    	// write into appropriate cell
    	$("#sum"+tip_index).text(sum_tips);
    }
    
    function recalc_tipsums() {
    	var counter = 0;
    	$(".tip").each( function() {
    		counter += 1;
    		setTipSum(counter);
    	});
    }
    
    function check_submit_valid() {
    	var allok = true;
    	$(".lfdtip_prognose").each( function() {
    		if ($(this).html() == "" ) {
    			allok = false;
    		}
    	});
    	if (allok) {
    		$("#button_for_submit").button( "option", "disabled", false );
    	} else {
    		$("#button_for_submit").button( "option", "disabled", true );    		
    	};
    	return allok;
    }
    
    function populate_formular() {
    	
        $.getJSON('/cgi-bin/cl/getFormular.pl', function(data) {
     	   var formular = $("#formular");
     	   $.each(data, function(key, val) {
     		//storing data in outer variable
     		formularhash[key] = val; 
     		 
     		var tr = $('<tr></tr>',{
     			"class": 'formrow',
     		});
     		 tr.appendTo(formular);
     		 var td = $('<td/>',{
     			 id: 'sp_'+key,
     			 "class": 'match',
     			 text: val.match,
     		 });
     		 td.appendTo(tr);
     		 var j1 = $('<span/>', {
     			 id: 'q1_'+key,
     			 "class": 'drp ui-widget-content quote_available',
     			 text: val.q1.wert,
     		 });
     		 j1.draggable({revert: false, helper:"clone"});
     		 j1.appendTo($('<td></td>').appendTo(tr));
     		 j1.mouseenter(function() {
     			active_quote = j1.attr('id'); 
     		 });
     		 
     		 var j2 = $('<span/>', {
     			 id: 'q0_'+key,
     			 "class": 'drp ui-widget-content quote_available',
     			 text: val.q0.wert,
     		 });
     		 j2.draggable({revert: false, helper:"clone"});
     		 j2.appendTo($('<td></td>').appendTo(tr));
     		 j2.mouseenter(function() {
     			active_quote = j2.attr('id');
      		 });

     		 var j3 = $('<div/>', {
     			 id: 'q2_'+key,
     			 "class": 'drp ui-widget-content quote_available',
     			 text: val.q2.wert,
     		 });
     		 j3.draggable({revert: false, helper:"clone"});
     		 j3.appendTo($('<td></td>').appendTo(tr));
     		 j3.mouseenter(function() {
     			active_quote = j3.attr('id');
      		 });

     	   });
     	 }).complete(function() { 
     		 // sorting the stuff by id
     		$('.formrow').sortElements(function(a, b){
     			//alert("Formrow a"+$(a)+" / "+$(a).children('.match').attr('id'));
     		    return $(a).children('.match').attr('id') > $(b).children('.match').attr("id") ? 1 : -1;
     		});
     		// coloring right.
      	   var odd_row = true;
     		$('.formrow').each(function(index){
         		odd_row = !odd_row;
         		var oddrow = odd_row?'odd':'even';
         		$(this).addClass('formrow'+oddrow);
     		});
     		 populate_tiparray(); 
     	 });;    	
    }
    
    function deleteTip(t_id) {
    	var info=tiparray[t_id];
    	//remove the tip
    	tiparray[t_id] = {};
    	
    	//enable the draggable again
		$("#"+info.form_id).siblings().children(".drp").draggable( "option", "disabled", false ); 
		$("#"+info.form_id).siblings().children(".drp").removeClass('quote_unavailable');
		$("#"+info.form_id).siblings().children(".drp").addClass('quote_available');
    			
    	//clean and enable the droppable again
		$("#"+t_id).droppable( "option","disabled", false);
		$("#"+t_id).text("").next().text("").next().text("");
		$("#"+t_id).prev().children('button').hide();
		$("#"+t_id).prev().children('span').show();
		//$("#"+t_id).parent().children("td.lfdtip_button").hide();
		
    }
    
    function build_tiptarget() {
    	
 	  $(".tip").each( function(index) {
    		 var myrow = $(this);
    		 var anztips = myrow.attr('anztips');
    		 for (var i = 1; i <= anztips; i++) {
    			 var tr = $('<tr/>');
    			 var td1 = $('<td/>', {
    				 "class": 'lfdtip_label ui-widget-content',
    			 });
    			 $('<span/>',{
    				 text: i,
    				 class: 'lfd_tip_nr_indicator',
    			 }).appendTo(td1);
    			 tr.appendTo(myrow);
    			 td1.appendTo(tr);
    			 var cell_ = $('<td/>', {
    				id: 's_'+(index+1)+'_t_'+i,
    				text: '',
    				"class": 'drptarg ui-widget-content',
    			 });
    			 cell_.droppable({
    				 accept: '.drp',
    				 "class" : 'lfdtip_match',
    				 tolerance: 'pointer',
    				 activeClass: "ui-state-hover",
    				 hoverClass: "ui-state-active",
    				 drop: function( event, ui) {

    					 // we need:  tipspiel_nr - tipspiel_tipnr - formgame_id - prognose
    					 
    					 var k = $(this).attr('id');
    					 var which_tip = k.match(/s_(\d)_t_(\d)/);
    					 var tipspiel_nr = RegExp.$1;
    					 var tipspiel_tipnr = RegExp.$2;

    					 var tip_id = ui.draggable.attr('id').match(/q(\d)_(\d*)/);
    					 var prognose = RegExp.$1;
    					 var formgame_id = RegExp.$2
    					 
    					 addtip(tipspiel_nr,tipspiel_tipnr,formgame_id,prognose);
    					 
    				 }
    			 });
    			 cell_.appendTo(tr);

    			 $('<td/>',{
    				 "class" : 'lfdtip_prognose ui-widget-content',

    			 }).appendTo(tr);
	 			 $('<td/>',{
	 				 "class" : 'lfdtip_quote ui-widget-content',
	 			 }).appendTo(tr);
	 			 //The remove button
	 			var lasttd = $('<td/>', {
	 					"class": 'lfdtip_deletebutton',
	 				}).hide().appendTo(tr);
	 			
	 			
	 		   	 var deletebutton = $('<button/>',{
	 		   		 "class": 'lfdtip_deletebutton_button',
	 		   	 }).button( {icons: {primary:'ui-icon-circle-close'},
	 		   		 	     text : false,
	 		   		 	     width: '16px',
	    		 	 }).click( function() {
	 					deleteTip($(this).parent().siblings('.drptarg').attr('id'));
	 					check_submit_valid();
	 					recalc_tipsums();
	 				});
	 		   	 deletebutton.hide().appendTo(td1);
    		 } // of for-loop
    		 
    		 // Table row for statistics
    		 var tr_stat_row = $('<tr/>');
    		 var td_stat_row = $('<td/>',{
    			 colspan:4,
    		 }).css('padding','0').appendTo(tr_stat_row);
    		 var stat_row = $('<table/>',{
     			"class": 'stat_row',
     			id: 'stat_'+(index+1),
     		 }).append('<tr><td class=tipsum id=sum'+(index+1)+'>0</td></tr>').appendTo(td_stat_row);
    		 
    		 //Einklinken.
    		 tr_stat_row.appendTo(myrow);
    		 //Breite anpassen.
    		 stat_row.width(myrow.width()+9);
    		 
	    });
    
    	  // The button for posting
    	  var subbutton = $("#button_for_submit").button( {icons: {primary:'ui-icon-arrowreturnthick-1-e'},
    		  disabled:true});
    	  subbutton.click(function() {
    		  submit_form();
    	  });

    	  
    	  // Adjust the heights of div1 and div2
    	  var m1 = $("div.centercontent").height();
    	  var m2 = $("div.leftcontent").height();
    	  if (m1 > m2) {
    		  //$("div.leftcontent").height(m1);
    	  } else {
    		//$("div.centercontent").height(m2);
    	  }
    	  
    }

    /**
     * jQuery.fn.sortElements
     * --------------
     * @param Function comparator:
     *   Exactly the same behaviour as [1,2,3].sort(comparator)
     *   
     * @param Function getSortable
     *   A function that should return the element that is
     *   to be sorted. The comparator will run on the
     *   current collection, but you may want the actual
     *   resulting sort to occur on a parent or another
     *   associated element.
     *   
     *   E.g. $('td').sortElements(comparator, function(){
     *      return this.parentNode; 
     *   })
     *   
     *   The <td>'s parent (<tr>) will be sorted instead
     *   of the <td> itself.
     */
    jQuery.fn.sortElements = (function(){
     
        var sort = [].sort;
     
        return function(comparator, getSortable) {
     
            getSortable = getSortable || function(){return this;};
     
            var placements = this.map(function(){
     
                var sortElement = getSortable.call(this),
                    parentNode = sortElement.parentNode,
     
                    // Since the element itself will change position, we have
                    // to have some way of storing its original position in
                    // the DOM. The easiest way is to have a 'flag' node:
                    nextSibling = parentNode.insertBefore(
                        document.createTextNode(''),
                        sortElement.nextSibling
                    );
     
                return function() {
     
                    if (parentNode === this) {
                        throw new Error(
                            "You can't sort elements if any one is a descendant of another."
                        );
                    }
     
                    // Insert before flag:
                    parentNode.insertBefore(this, nextSibling);
                    // Remove flag:
                    parentNode.removeChild(nextSibling);
     
                };
     
            });
     
            return sort.call(this, comparator).each(function(i){
                placements[i].call(getSortable.call(this));
            });
     
        };
     
    })();    