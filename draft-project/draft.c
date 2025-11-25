#include <stdio.h>
#include <stdlib.h>

enum
{
    MAXLEN = 64
};

typedef struct Node
{
    char college[MAXLEN];
    char name[MAXLEN];
    int draftPosition;
    char team[MAXLEN];
    struct Node *next;
} Node;

static Node *insertSorted(Node *head, Node *n);

static void free_list(Node *head)
{
    while(head != NULL)
    {
        Node *next = head -> next;
        free(head);
        head = next;
    }
}

static int node_cmp(const Node *a, const Node *b)
{
    int i = 0;
    while(a -> college[i] != '\0' && b -> college[i] != '\0' && a -> college[i] == b -> college[i])
    {
        i++;
    }
    int c = (int)a -> college[i] - (int) b -> college[i];
    if(c != 0) return c;
    return a -> draftPosition - b -> draftPosition;
}

static Node *insertSorted(Node *head, Node *n)
{
    if(!head || node_cmp(n, head) < 0)
    {
        n -> next = head;
        return n;
    }
    Node *cur = head;
    while(cur -> next && node_cmp(n, cur -> next) >= 0) cur = cur -> next;
    n -> next = cur -> next;
    cur -> next = n;
    return head;
}


int main(int argc, char *argv[])
{
    // struct sPerson *newPerson = (struct sPerson*) malloc(sizeof(struct sPerson));
    // printf("%p\n", (void*)newPerson);

    if(argc != 2)
    {
        return EXIT_SUCCESS;
    }

    FILE *fp = fopen(argv[1], "r");

    if(!fp)
    {
        return EXIT_SUCCESS;
    }

    Node *head = NULL;
    int pick = 1;

    char namebuf[128], collegebuf[128], teambuf[128];

    while(fgets(namebuf, sizeof namebuf, fp))
    {
        for(int i = 0; namebuf[i] != '\0'; i++)
        {
            if(namebuf[i] == '\n')
            {
                namebuf[i] = '\0'; break;
            }
        }
        if(namebuf[0] == 'D' && namebuf[1] == 'O' && namebuf[2] == 'N' && namebuf[3] == 'E' && namebuf[4] == '\0')
        {
            break;
        }
        if(!fgets(collegebuf, sizeof collegebuf, fp)) break;
        for(int i = 0; collegebuf[i] != '\0'; ++i)
        {
            if(collegebuf[i] == '\n')
            {
                collegebuf[i] = '\0'; break;
            }
        }
        if(!fgets(teambuf, sizeof teambuf, fp)) break;

        for(int i = 0; teambuf[i] != '\0'; ++i)
        {
            if(teambuf[i] == '\n')
            {
                teambuf[i] = '\0'; break;
            }
        }
            
        Node *n = (Node*) malloc(sizeof(Node));
        if(!n)
        {
            fclose(fp); free_list(head); return EXIT_SUCCESS;
        }

        n -> next = NULL;
        n -> draftPosition = pick++;

        int iName = 0;
        while(iName < MAXLEN - 1 && namebuf[iName] != '\0')
        {
            n -> name[iName] = namebuf[iName];
            iName++;
        }

        n -> name[iName] = '\0';
        
        int iCollege = 0;
        while(iCollege < MAXLEN - 1 && collegebuf[iCollege] != '\0')
        {
            n -> college[iCollege] = collegebuf[iCollege];
            iCollege++;
        }
        n -> college[iCollege] = '\0';

        int iTeam = 0;
        while(iTeam < MAXLEN - 1 && teambuf[iTeam] != '\0')
        {
            n -> team[iTeam] = teambuf[iTeam];
            iTeam++;
        }
        n -> team[iTeam] = '\0';
        head = insertSorted(head, n);

    }



    for(Node *cur = head; cur; cur = cur -> next)
    {
        printf("%s: %s, %d, %s\n", cur -> college, cur -> name, cur -> draftPosition, cur -> team);
    }

    fclose(fp);
    free_list(head);
    return EXIT_SUCCESS;

}