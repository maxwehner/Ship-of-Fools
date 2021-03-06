xquery version "3.1";
(: This file handles the forms of synopsis.html. :)

module namespace syn1 = "http://oc.narragonien-digital.de/syn1";
declare default element namespace "http://www.tei-c.org/ns/1.0";

(: Modules needed for turning pages :)
import module namespace syn5 = "http://oc.narragonien-digital.de/syn5" at "synopsis5.xql";

import module namespace templates = "http://exist-db.org/xquery/templates";
import module namespace config = "http://exist-db.org/apps/narrenapp/config" at "config.xqm";
import module namespace functx = "http://www.functx.com";

declare function syn1:createForm($node as node(), $model as map(*)) {
(: Creates a second form. Takes parameters the user has chosen from the first form and keeps them hidden 
in the second form.
Input: html-form from synopsis-page
Output: second form with hidden parameters the user has chosen from first form :)
    
    (: takes chosen parameters for version, book and chapter from form1 :)
    let (:$vers := request:get-parameter('vers1', ''),:)
         $book := request:get-parameter('book1', ''),
         $chap := request:get-parameter('chap1', '')
    return
        
        <form
            action="?">
            <!-- Enthält die einzelnen Auswahlen -->
            <div
                class="row">
                <!-- imports function for turning pages in both chosen narrenschiff simultaneously -->
                <div
                    class="col-md-1">
                    { syn5:create-link-tall($node, $model, "next", "r") }
                </div>
                <!-- ausgabe2 class is necessary for synopsis1.js-file -->
                <!-- chosen-select is class for chosen jquery plugin -->
                <div
                    class="col-md-11">
                    <div
                        class="row">
                        <div
                            class="col-md-7">
                            <select
                                class="ausgabe2 chosen-select synMenu"
                                id="ausgabe2"
                                data-placeholder="Ausgabe wählen"
                                name="book2"
                                style="width:100%">
                                <input
                                    type="hidden"
                                    name="book1"
                                    value="{$book}"/>
                            </select>
                        </div>
                        <div
                            class="col-md-5">
                            <select
                                class="kapitel2 chosen-select synMenu"
                                id="kapitel2"
                                data-placeholder="Kapitel wählen"
                                name="chap2"
                                onchange="this.form.submit()"
                                style="width:100%">
                                <input
                                    type="hidden"
                                    name="chap1"
                                    value="{$chap}"/>
                            </select>
                        </div>
                    </div>
                </div>
                
            </div>
        </form>
};
