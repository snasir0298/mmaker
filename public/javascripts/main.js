$(document).ready(function(){
    soundManager.url = 'swf/'; // directory where SM2 .SWFs live
    $('#slider').nivoSlider({
        startSlide:0, //Set starting Slide (0 index)
        slideshowEnd: function(){
            $('#slider').data('nivo:vars').stop = true;
        }
    });
    $('#slider').data('nivoslider').stop();
});

var sounds = [];
var images = [];
var new_images = [];
var backgroundSound = "";
var first = true;

function play_media(sounds_arr,images_arr,bg_sound){    
    soundManager.useFlashBlock = false;
    var soundIndex;
    var currentTimer;

    set_bg_sound(bg_sound); // Set BackGround Music to play
    set_sounds(sounds_arr); // Setting the sounds to play
    set_images(images_arr); // Setting the images to display

    var playSoundIfPresent = function (maybeSound) {
        if (maybeSound != null) {
            maybeSound.setVolume(100);
            maybeSound.play();
        }
    }

    var changeSound = function changeSound() {
        if (sounds[soundIndex].sound != null) {
            sounds[soundIndex].sound.stop();
        }
        soundIndex += 1;
        if (soundIndex < sounds.length && $('.action').attr('value') == 'Stop') {
            $('#slider').data('nivoslider').start();
            get_sound_images(sounds[soundIndex].s_id);
            playSoundIfPresent(sounds[soundIndex].sound);
            currentTimer = setTimeout(changeSound, sounds[soundIndex].duration);
            $('#slider').nivoSlider({
                effect:'random', // Specify sets like: 'fold,fade,sliceDown'
                animSpeed:500, // Slide transition speed
                pauseTime:30000, // How long each slide will show
                startSlide:0, // Set starting Slide (0 index)
                directionNav:true, // Next & Prev navigation
                directionNavHide:true, // Only show on hover
                controlNav:true, // 1,2,3... navigation
                controlNavThumbs:false, // Use thumbnails for Control Nav
                controlNavThumbsFromRel:false, // Use image rel for thumbs
                controlNavThumbsSearch: '.jpg', // Replace this with...
                controlNavThumbsReplace: '_thumb.jpg', // ...this in thumb Image src
                keyboardNav:true, // Use left & right arrows
                pauseOnHover:false, // Stop animation while hovering
                manualAdvance:false, // Force manual transitions
                captionOpacity:0.8, // Universal caption opacity
                prevText: 'Prev', // Prev directionNav text
                nextText: 'Next' // Next directionNav text
            });

        } else {
            // Organic ending
            backgroundSound.stop();
            $('.action').attr('value', 'Play');
            $('#slider').nivoSlider({
                startSlide:0 //Set starting Slide (0 index)                
            });
            $('#slider').data('nivoslider').stop();
        }
    }

    if ($('.action').attr('value') === 'Play') {        
        backgroundSound.setVolume(40);
        backgroundSound.play();
        soundIndex = 0;
        $('.action').attr('value', 'Stop');
        playSoundIfPresent(sounds[soundIndex].sound);
        get_sound_images(sounds[soundIndex].s_id);
        currentTimer = setTimeout(changeSound, sounds[soundIndex].duration);
    }
    else {
        clearTimeout(currentTimer);
        soundManager.stopAll();
        $('.action').attr('value', 'Play');        
        $('#slider').nivoSlider({
            startSlide:0 //Set starting Slide (0 index)            
        });
        $('#slider').data('nivoslider').stop();
    }
}

function get_sound_images(sound_id){    
    count = 0;
    new_images = []
    $("#slider").html();
    $.each(images,function(k,img){
        if(sound_id == img.sound || (img.sound == "" && sound_id == undefined && first == true)){
            new_images[count] = img;
            count += 1;
            if(img.sound == ""){
                first = false;
            }
            $("#slider").append("<img src='"+img.src+"' alt='' />");
        }
    })
}

function set_sounds(sounds_arr){
    $.each(sounds_arr, function(i,item){
        data = JSON.parse(item);
        if(data.id == undefined || data.id == ""){
            sounds[i] = {
                sound: null,
                duration: data.duration
            }
        }
        else{
            sounds[i] = {
                sound: soundManager.createSound({
                    id: data.id,
                    url: data.url
                }),
                s_id: data.id,
                duration: data.duration
            };
        }
    });
}

function set_images(images_arr){
    $.each(images_arr, function(i,item){
        data = JSON.parse(item);
        images[i] = {
            src: data.src,
            alt: data.alt,
            from: data.from,
            to: data.to,
            time: data.time,
            sound: data.sound
        };
    });
}

function set_bg_sound(bg_sound){
    $.each(bg_sound, function(i,item){
        data = JSON.parse(item);
        backgroundSound = soundManager.createSound({
            id: data.id,
            url: data.url
        });
    })
}