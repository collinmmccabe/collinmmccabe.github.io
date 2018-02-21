clear all
clc

r=0%0.07;
c=0.01;
b=4*c;
p=1.5*c;
q=1.5*c;
k=1.5*c;
a=2;
e=0.1;
n=18;
T=25;
W0=1;

% loop through each Tau (where Tau is threshold required of punishers) and X (where X is # of punishers), 
% and for each calculate the payoff of the Boyd P and N strategies
for Tau=0:(n-1)
    Tau
    for X=0:n

        % x is the fraction of P players in the population of size n
        x=X/n;
        
        % initialize each of these for this [tau,X] pairing
        WpShort=0;
        WpLong=0;
        WnShort=0;
        WnLong=0;
        
        % cacluate the fitnesses as per the Boyd et al paper. note that
        % Pr(j|P) comes the from binomial distribution (binopdf) using
        % p=(r+(1-r)*x) and N=n-1, and similarly for Pr(j|N)
        for j=Tau:(n-1)
            WpShort=WpShort+(binopdf(j,n-1,r+(1-r)*x)*(-(e*(j+1)+(n-1-j))*k/((j+1)^a)+(1-e)*(b*(j+1)/n-c)));
        end
        for j=Tau:(n-1)
            WpLong=WpLong+(binopdf(j,n-1,r+(1-r)*x)*((b-c)*(1-e)-(n*e*k)/((j+1)^a)-e*p));
        end
        for i=(Tau+1):(n-1)
            WnShort=WnShort+(binopdf(i,n-1,(1-r)*x)*(-p+((1-e)*i*b)/n));
        end
        for i=(Tau+1):(n-1)
            WnLong=WnLong+(binopdf(i,n-1,(1-r)*x)*((b-c)*(1-e)-e*p));
        end
        
        % store the fitness (use Tau+1 and X+1 instead of Tau and X because
        % matrix indices have to be >0)
        Wp(Tau+1,X+1)=W0-q+WpShort+(T-1)*WpLong;
        Wn(Tau+1,X+1)=W0+WnShort+(T-1)*WnLong;
        
    end
end

% Change default axes fonts.
set(0,'DefaultAxesFontName', 'Times New Roman')
set(0,'DefaultAxesFontSize', 20)

% Change default text fonts.
set(0,'DefaultTextFontname', 'Times New Roman')
set(0,'DefaultTextFontSize', 20)

% plot a line at level 0 in the (Wp-Wn) space, to show where the
% equilibriua points are
axes('FontSize',20);
contour([0:n-1],[0:n]/n,(Wp-Wn)',[0 ,0],'k');
xlabel('Threshold number of P'); ylabel('Equilibrium frequency of P')