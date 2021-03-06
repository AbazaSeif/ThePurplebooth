<?php
include $_SERVER['DOCUMENT_ROOT'] . '/thepurplebooth/includes/links.php';
require_once "database/image_info.php";
require_once "database/users.php";
?>

<html>
	<head>
		<title>Gallery</title>
		<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<script type="text/javascript" src="js/gallery/imagesloaded.pkgd.js"></script>
		<script type="text/javascript" src="js/gallery/jquery.wookmark.js"></script>
		<script type="text/javascript" src="js/gallery/gallery.js"></script>
		<link rel="stylesheet" type="text/css" href="css/gallery.css" />
		
		<!--  Styling code.. Do Not Touch.. -->
	
		<script type="text/javascript">
			(function ($){
					imagesLoaded('#tiles', function() {
						var options = {
						itemWidth: 200, // Optional min width of a grid item
		          		autoResize: true, // This will auto-update the layout when the browser window is resized.
		          		container: $('#tiles'), // Optional, used for some extra CSS styling
		          		offset: 5, // Optional, the distance between grid items
		          		outerOffset: 20, // Optional the distance from grid to parent
		          		flexibleWidth: 300 // Optional, the maximum width of a grid item
		        	};
		
			        var handler = $('#tiles li');
			        handler.wookmark(options);
			        
			        $(window).load( function() {
			        	handler.wookmark(options);
			        });
	    		});
				})(jQuery);

		</script>	
  
	</head>
	<body>
		
		<div class="container" style="width: auto; min-height: 100%;">
			<?php
				include $_SERVER['DOCUMENT_ROOT'] . '/thepurplebooth/includes/masterpage.php';
				$category = $_GET['category'];
				$project = $_GET['project'];
				$user_id = $_GET['userid'];
				$user_data = get_user_info_by_id($user_id);
				if(isset($_SESSION['thepurplebooth_user_id']))
					$logged_user_id = $_SESSION['thepurplebooth_user_id'];			
			?>
			
			<div id="gallery-categories">
				<span id="image-filter-heading"><h4>Image Filters: </h4></span>
				<div class="btn-group project-filters">
					<button type="button" class="btn btn-inverse dropdown-toggle" data-toggle="dropdown" style="border-radius: 0px;">
						Category <?php 
						if($category == 'myimages'){
							echo "- "."My Images";
						}
						else{
							echo "- ".ucfirst($category);
						} 
						?>
						<span class="caret"></span>
					</button>
					
					<ul class="dropdown-menu">
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li></li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=all&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">All</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=portrait&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Portrait</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=landscape&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Landscape</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=wildlife&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Wildlife</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=architecture&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Architecture</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=street&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Street</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=wedding&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Wedding</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=macro&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Macro</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=abstract&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Abstract</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=hdr&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">HDR</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=event&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Event</a> </li>
						<li> <a href="http://localhost:8888/thepurplebooth/gallery.php?category=sport&project=<?php echo $project;?>&userid=<?php echo $user_id;?>">Sport</a> </li>
					</ul>
				</div>
				
				<div class="btn-group project-filters">
					<a class="btn btn-inverse" style="border-radius: 0px;" href="http://localhost:8888/thepurplebooth/gallery.php?category=<?php echo $category;?>&project=all&userid=<?php echo $user_id;?>">All</a>
					<a class="btn btn-inverse" style="border-radius: 0px;" href="http://localhost:8888/thepurplebooth/gallery.php?category=<?php echo $category;?>&project=new&userid=<?php echo $user_id;?>">Open</a>
					<!--<a class="btn btn-inverse" style="border-radius: 0px;" href="http://localhost:8888/thepurplebooth/gallery.php?category=<?php echo $category;?>&project=new&userid=<?php echo $user_id;?>">In Progress</a>-->
					<a class="btn btn-inverse" style="border-radius: 0px;" href="http://localhost:8888/thepurplebooth/gallery.php?category=<?php echo $category;?>&project=completed&userid=<?php echo $user_id;?>">Completed</a>
				</div>
				
			</div>
			
			<!--<div>
				<?php
				if ($user_id !="all"){
					echo "<h4>You are viewing ".$user_data['user_name']."'s gallery</h4>";
					?><p>Click <a href="/thepurplebooth/gallery.php?category=all&project=all&userid=all">here</a> to view complete gallery</p>
				<?php } ?>
			</div>-->
			
				<?php
 					echo '<div id="images-container" role="main">';
 					echo '<ul id="tiles">'; //echo '<ul class="thumbnails">';
					
 					get_filtered_images($category,$project,$user_id);
					
					echo '</ul>';
 					echo '</div>';			
				?>
		
	</div>
		<?php
		include $_SERVER['DOCUMENT_ROOT'] . '/thepurplebooth/includes/footer.php';
		?>
	</body>
</html>
