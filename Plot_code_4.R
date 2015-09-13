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


par(mfrow=c(2,2),bg="transparent",pty="m") # Returning pty to normal
par(cex=0.6)
with(D,plot(Date,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))

with(D,plot(Date,Voltage,type="l"))

with(D,plot(Date,Sub_metering_1,ylab="Energy sub metering",xlab=" ",type="n"))
with(D,lines(Date,Sub_metering_1,col="black",type="l"))
with(D,lines(Date,Sub_metering_2,col="red",type="l"))
with(D,lines(Date,Sub_metering_3,col="blue",type="l"))
legend("topright",lty=1,box.col="transparent",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))

with(D,plot(Date,Global_reactive_power,type="l"))
