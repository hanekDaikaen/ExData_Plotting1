###  DATA LOAD  ###


#Extract a subset of data which includes the ones I will use

D1 <- read.table("~/R/Plots/household_power_consumption.txt",sep=";",comment.char=" ",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),nrows=5000,skip=64800,na.strings="?")


# From them, extracts the targeted ones

one <- D1[,1]=="1/2/2007"
two <- D1[,1]=="2/2/2007"
both <- one | two

D2 <- D1[both,]


# Converts date and time into date/time class in one column

Date <- strptime(paste(D2[,1],D2[,2]),format="%d/%m/%Y %H:%M:%S");

D3 <- cbind(Date,D2[3:9])


# Change names to the ones of the data

Names <- read.table("~/R/Plots/household_power_consumption.txt",sep=";",comment.char=" ",colClasses="character",nrows=1,na.strings="?")
names(D3)[2:8] <- Names[3:9]

D <- D3


###  PLOT  ###


par(cex=0.7, bg="transparent")
with(D,plot(Date,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
