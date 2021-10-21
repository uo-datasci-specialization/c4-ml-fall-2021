

1) From digitalocean, create a droplet using the following template
at least 4GB ram and 80 GB disk

https://marketplace.digitalocean.com/apps/rstudio

2) Then, from the digital ocean account access the server from the root account, open R,
and install all the packages (quanteda, text, udpipe, reticulate, python modules, etc.)

3) Make sure the code runs after all this in the root account

4) Then, create additional users as many as you need (depending on # of students) using 
                                                      
    adduser xyz 
    deluser xyz --remove-all-files
    
5) For each user, log into the account and run the code to install reticulate, 
miniconda, and python modules

  require(quanteda)
  require(quanteda.textstats)
  require(udpipe)
  require(text)
  require(reticulate)

  install_miniconda()

  conda_install(envname = 'r-reticulate', c('torch'), pip = TRUE)
  conda_install(envname = 'r-reticulate', c('transformers'), pip = TRUE)
  conda_install(envname = 'r-reticulate', c('nltk'), pip = TRUE)
  conda_install(envname = 'r-reticulate', c('tokenizers'), pip = TRUE)
  conda_install(envname = 'r-reticulate', c('numpy'), pip = TRUE)

	try (...,pip=FALSE) if the above doesn't work

6) Restart the session, log out, and then log in again.

7) Then, run the following. If you get the numbers at the end, you are good.

	readability <- read.csv('https://raw.githubusercontent.com/uo-datasci-specialization/c4-ml-fall-2021/main/data/readability.csv',header=TRUE)

	str(readability)

	text <- as.character(readability[1,]$excerpt)
	text

	require(reticulate)
	require(text)

	reticulate::import('torch')
	reticulate::import('numpy')
	reticulate::import('transformers')
	reticulate::import('nltk')
	reticulate::import('tokenizers')


	tmp1 <- textEmbed(x     = 'sofa',
        	          model = 'roberta-base',
                	  layers = 1)

	tmp1$x
    