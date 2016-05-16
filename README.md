# reaktor-orbital-challenge
Code used for the challenge at https://reaktor.com/orbital-challenge/

# How it works
The main idea of the algorithm is to create an adjacency matrix, indicating which satellite are in visibility of each other.
The origin and the destination of the call are handled as satellite (but on ground, altitude = 0).

To compute which satellite are viewed by another one, some simple geometry is used. I compute the angle alpha between the "Center of the Earth-Satellite(i)" line and the "Satellite(i)-Tangent to the Earth". Then I compute the angle beta between "Center of the Earth-Satellite(i)" and "Satellite(i)-Satellite(j)". If beta \> alpha, the satellite are in sight. Note that alpha \< beta does not necessarly mean that they are not visible, but I symetrize the matrix later, which should be enough to handle corner case where a satellite is "above" another one.

\[Should insert a picture, better than a thousand words, but I have no picture\]

Once I have the adjacency matrix, I just use a simple BFS algorithm to find the path with the smaller number of satellites.

Should work on any file, sorry that I don't have any fancy visualisation, and that the code is poorly documented. Also I have slightly modified it since my submission, I hope it still works as expected.
