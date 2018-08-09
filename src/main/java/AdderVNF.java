import vfn.BaseVNF;
import vfn.testvnfs.AddStringVNF;

import java.io.IOException;

public class AdderVNF extends BaseVNF {

    private String toAdd;

    public AdderVNF(String toAdd, int port) {
        super(port);
        this.toAdd = toAdd;
    }

    public String functionality(String message) {
        int ind = message.lastIndexOf("\r\n");
        if( ind>=0 )
            message = new StringBuilder(message).replace(ind, ind+1,toAdd + "\r\n").toString();
        return message;
    }

    public static void main(String[] args) {
        System.out.println("string to add: " + args[0]);
        System.out.println("port:          " + args[1]);
        try {
            new AddStringVNF(args[0], Integer.parseInt(args[1])).execute();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
