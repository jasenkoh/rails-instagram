(function(){var t;this.INC_FOLLOWERS=1,this.DEC_FOLLOWERS=-1,$(document).ready(function(){var n;return n=$("input[name=followed_id]").val(),$(".relationship-block").on("click",".unfollow",function(){var e;return e=API.getRelationshipsUrl().format(n),Relationship.editRelationship("DELETE",e).done(function(n){return t(DEC_FOLLOWERS,n)}).fail(function(t){return console.log(t),alert("Something bad happened")})}),$(".relationship-block").on("click",".follow",function(){var e;return e=API.getRelationshipsUrl(!0).format(n),Relationship.editRelationship("POST",e).done(function(n){return t(INC_FOLLOWERS,n)}).fail(function(t){return console.log(t),alert("Something bad happened")})})}),this.Relationship={},Relationship.editRelationship=function(t,n){return $.ajax({url:n,type:t})},t=function(t,n){var e;return $(".relationship-block").empty(),$(".relationship-block").append(n),e=$(".followers-stat").text().trim(),e=parseInt(e),t=parseInt(t),e+=t,$(".followers-stat").text(e)}}).call(this);